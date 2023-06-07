{
  description = "Shyrogan's Nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});

      mkNixos = modules: nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = { inherit inputs outputs; };
      };
      mkHome = modules: pkgs: home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    in 
    {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; }));

      nixosConfigurations = {
        mizu = mkNixos [ ./hosts/mizu ];
      };
      homeConfigurations = {
        "shyrogan@mizu" = mkHome [ ./home/shyrogan/mizu.nix ] nixpkgs.legacyPackages."x86_64-linux";
      };
    };
}
