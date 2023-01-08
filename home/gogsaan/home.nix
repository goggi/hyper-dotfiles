{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
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
          # ".config/WebCord"
          ".config/vpn"
          ".config/sops"
          ".config/obsidian"
          ".config/Yubico"
          ".config/1Password"
          ".config/microsoft-edge"
          ".mozilla"
          ".ssh"
          ".aws"
          ".local/share/keyrings"
          ".local/share/applications"
          ".local/share/desktop-directories"
          # {
          #   directory = ".ssh";
          # }
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
