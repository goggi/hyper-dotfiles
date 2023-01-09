{
  config,
  inputs,
  pkgs,
  lib,
  system,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    # Apps
    ../catalog/apps/core.nix
    ../catalog/apps/googleChromeBeta.nix
    ../catalog/apps/vscode.nix
    ../catalog/apps/1password.nix
    ../catalog/apps/obsidian.nix
    ../catalog/apps/k8sManagment.nix
    ../catalog/apps/signalDesktop.nix
    ../catalog/apps/firefox
    ../catalog/apps/steam.nix
    ../catalog/apps/kitty.nix
    ../catalog/apps/obsStudio.nix
    ../catalog/apps/webcord.nix

    # Development
    ../catalog/dev/nodejs.nix
    ../catalog/dev/python3.nix

    # Features
    ../catalog/features/shell
    ../catalog/features/cli
    ../catalog/features/yubikey.nix

    # Desktops
    ../catalog/desktops/hyprland
  ];

  home = {
    username = "gogsaan";
    homeDirectory = "/home/gogsaan";
    stateVersion = "22.11";
    extraOutputsToInstall = ["doc" "devdoc"];
    # Seems like it needs to be commented out on first boot,
    persistence = {
      "/persist/home/gogsaan" = {
        directories = [
          "Documents"
          "Applications"
          "Downloads"
          "Pictures"
          "Videos"
          "Projects"
          ".config/certs"
          ".config/vpn"
          ".config/sops"
          ".ssh"
          ".aws"
          ".local/share/keyrings"
          ".local/share/applications"
          ".local/share/desktop-directories"
        ];
        files = [
          ".zsh_history"
        ];
        allowOther = true;
      };
    };
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
