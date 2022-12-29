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
    ../shared/users/gogsaan.nix
  ];

  boot = {
    #kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = ["aarch64-linux"];
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [];

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
        configurationLimit = 20;
      };
    };
  };

  hardware = {
    opengl = {
      enable = true;
    };

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
  };

  services = {
    btrfs.autoScrub.enable = true;
    acpid.enable = true;
    thermald.enable = true;
    upower.enable = false;

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "gogsaan";
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
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # enable hyprland
  programs.hyprland.enable = true;
  programs.xwayland.enable = true;
  services.gnome.gnome-keyring.enable = true;

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
      libva-utils
      ocl-icd
      qt5.qtwayland
      qt5ct
    ];

    variables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  system.stateVersion = lib.mkForce "22.11"; # DONT TOUCH THIS
}
