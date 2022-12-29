{
  config,
  inputs,
  pkgs,
  lib,
  system,
  ...
}: {
  imports = [
    # ./cfgs/waylandDesktopFiles.nix
    ./home.nix
    ./packages.nix
    ../common/pkgs/AstroNvim.nix
    # ../common/pkgs/Webcord.nix

    ./modules/shell
    ./modules/desktop/windowManagers/hyprland
    # ./modules/programs/webcord.nix
    ./modules/programs/firefox
    ./modules/programs/discord.nix
    ./modules/programs/vscode.nix
    #./modules/programs/helix.nix
    ./modules/programs/kitty.nix
    # ./modules/programs/edge.nix
    ./modules/programs/mpd.nix
    ./modules/programs/obs-studio.nix
    # ./modules/programs/vscode.nix
    ./modules/programs/zathura.nix
  ];
}
