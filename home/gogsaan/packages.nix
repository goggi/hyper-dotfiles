{
  inputs,
  pkgs,
  config,
  ...
}: let
  # mpv-unwrapped = pkgs.mpv-unwrapped.overrideAttrs (o: {
  #   src = pkgs.fetchFromGitHub {
  #     owner = "mpv-player";
  #     repo = "mpv";
  #     rev = "48ad2278c7a1fc2a9f5520371188911ef044b32c";
  #     sha256 = "sha256-6qbv34ysNQbI/zff6rAnVW4z6yfm2t/XL/PF7D/tjv4=";
  #   };
  # });
in {
  home.packages = with pkgs; [
    polkit_gnome
    appimage-run
    ddcutil
    alsa-lib
    xorg.xlsclients
    alsa-plugins
    alsa-tools
    alsa-utils
    bandwhich
    bc
    bash
    blueberry
    cached-nix-shell
    cinnamon.nemo
    coreutils
    dconf
    findutils
    fzf
    glib
    nano
    inotify-tools
    killall
    libappindicator
    libnotify
    libsecret
    nodejs
    cmake
    pamixer
    pavucontrol
    # pulseaudio
    python3
    rsync
    util-linux
    wirelesstools
    xarchiver
    xclip
    xdg-utils
    xh
    xorg.xhost
    _1password
    _1password-gui-beta
    google-chrome-beta
    # imagemagick
    #glxinfo
    #ffmpeg-full
    #cairo
    # darkman
    # inputs.webcord.packages.${pkgs.system}.default
    #hyperfine
    #gnumake
    #gnuplot
    #gnused
    #gnutls
    #grex
    #libreoffice-fresh
    #mpv-unwrapped
    #psmisc
    #todo
    #trash-cli
    # microsoft-edge-dev
  ];
  # xdg.desktopEntries.microsoft-edge = {
  #   name = "Microsoft Edge";
  #   exec = "microsoft-edge --enable-features=UseOzonePlatform --ozone-platform=wayland";
  # };
  # xdg.desktopEntries.microsoft-edge-dev = {
  #   name = "Microsoft Edge Besta";
  #   exec = "microsoft-edge-dev --enable-features=UseOzonePlatform --ozone-platform=wayland";
  # };

  # APP Configurtaions
  # Darkman
  # xdg.configFile."darkman/config.yaml".text = import ./cfgs/darkman/darkman.nix;
  # xdg.dataFile."dark-mode.d/gtk-theme.sh".text = import ./cfgs/darkman/light/gtk-theme.nix;
}
