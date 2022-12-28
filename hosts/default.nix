inputs: let
  inherit (inputs) self;
  inherit (self.lib) nixosSystem;

  sharedModules = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit inputs self;};
        users.gogsaan = ../home/gogsaan;
      };
    }
  ];
in {
  gza = nixosSystem {
    modules =
      [
        ./gza
        {networking.hostName = "gzaty";}
        inputs.hyprland.nixosModules.default
      ]
      ++ sharedModules;

    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
  };
}
