# This file (and the global directory) holds config that i use on all hosts
{
  lib,
  pkgs,
  self,
  inputs,
  ...
}: {
  imports = [
    ./sops.nix
    ./ssh.nix
    ./yubikey.nix
    ./fonts.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
  ];

  security = {
    rtkit.enable = true;

    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };

    pam = {
      services.login.enableGnomeKeyring = true;

      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];
    };
  };

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse.wantedBy = ["default.target"];
  };

  services = {
    blueman.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    lorri.enable = true;
    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';
    fish.promptInit = ''eval "$(${pkgs.starship}/bin/starship init fish | source)"'';

    adb.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;

    npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.npm
        color = true
      '';
    };

    java = {
      enable = true;
      package = pkgs.jre;
    };
  };

  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [fish];
    # shells = with pkgs; [zsh];

    systemPackages = with pkgs; [
      curl
      gcc
      git
      htop
      hddtemp
      jq
      lm_sensors
      lz4
      ntfs3g
      nvme-cli
      p7zip
      pciutils
      unrar
      unzip
      wget
      zip
    ];

    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(gnome-keyring-daemon --start --daemonize --components=ssh)
      eval $(ssh-agent)
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';

    variables = {
      EDITOR = "nano";
      BROWSER = "firefox";
    };
  };

  console = let
    normal = ["181825" "F38BA8" "A6E3A1" "F9E2AF" "89B4FA" "F5C2E7" "94E2D5" "BAC2DE"];
    bright = ["1E1E2E" "F38BA8" "A6E3A1" "F9E2AF" "89B4FA" "F5C2E7" "94E2D5" "A6ADC8"];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };
}
