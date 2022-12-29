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
    # persistence = {
    #   "/persist/home/gogsaan" = {
    #     directories = [
    #       "Documents"
    #       "Downloads"
    #       "Pictures"
    #       "Videos"
    #       "Projects"
    #       {
    #         directory = ".ssh";
    #         mode = "0700";
    #       }
    #       {
    #         directory = ".gnupg";
    #         mode = "0700";
    #       }
    #       {
    #         directory = ".local/share/keyrings";
    #         mode = "0700";
    #       }
    #       {
    #         directory = ".nixops";
    #         mode = "0700";
    #       }
    #       {
    #         directory = ".mozilla";
    #       }
    #       {
    #         directory = ".config/Code";
    #       }
    #     ];
    #     files = [
    #       ".zsh_history"
    #     ];
    #     allowOther = true;
    #   };
    # };
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
