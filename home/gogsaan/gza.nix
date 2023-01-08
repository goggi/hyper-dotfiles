{
  config,
  inputs,
  pkgs,
  lib,
  system,
  ...
}: {
  imports = [
    # Apps
    # ../catalog/apps/microsoft-edge.nix
    ../catalog/apps/google-chrome-beta.nix
    # ../catalog/apps/chromium.nix
    # ../catalog/apps/firefox-beta
    ../catalog/apps/vscode.nix
    ../catalog/apps/signal-desktop.nix
    ../catalog/apps/firefox

    ../catalog/features/cli

    # ../catalog/apps/google-chrome-dev.nix

    # ../catalog/apps/vivaldi.nix

    ./home.nix
    ./packages.nix

    ./modules/programs/steam.nix
    # ../common/pkgs/Webcord.nix

    ./modules/shell

    ./modules/desktop/windowManagers/hyprland
    # ./modules/programs/webcord.nix
    # ./modules/programs/discord.nix
    # ./modules/programs/vscode.nix
    #./modules/programs/helix.nix
    ./modules/programs/kitty.nix
    # ./modules/programs/edge.nix
    # ./modules/programs/mpd.nix
    ./modules/programs/obs-studio.nix
    # ./modules/programs/vscode.nix
    ./modules/programs/zathura.nix
  ];
}
