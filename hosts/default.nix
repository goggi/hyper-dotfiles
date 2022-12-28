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
        users.tyyago = ../home/tyyago;
      };
    }
  ];
in {
  acer = nixosSystem {
    modules =
      [
        ./acer
        {networking.hostName = "acerty";}
        inputs.hyprland.nixosModules.default
      ]
      ++ sharedModules;

    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
  };
}
