{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Shared configuration across all machines
    ../shared
    ../shared/users/tyyago.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ ];

    supportedFilesystems = ["btrfs"];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      systemd-boot.enable = false;

      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        useOSProber = false;
        enableCryptodisk = true;
        configurationLimit = 3;
      };
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
		rocm-opencl-icd
		rocm-opencl-runtime
		amdvlk
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        driversi686Linux.amdvlk
      ];
    };

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
  };

  # compresses half the ram for use as swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services = {
    btrfs.autoScrub.enable = true;
    acpid.enable = true;
    thermald.enable = true;
    upower.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "tyyago";
        };
        default_session = initial_session;
      };
    };

    # add hyprland to display manager sessions
    xserver.displayManager.sessionPackages = [inputs.hyprland.packages.${pkgs.system}.default];
  };

  # selectable options
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # enable hyprland
  programs.hyprland.enable = true;

  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  environment = {
    systemPackages = with pkgs; [
      acpi
      brightnessctl
      libva-utils
      ocl-icd
      qt5.qtwayland
      qt5ct
      vulkan-tools
    ];

    variables = {
      NIXOS_OZONE_WL = "1";
      WLR_BACKEND = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  system.stateVersion = lib.mkForce "22.11"; # DONT TOUCH THIS
}
