{
  description = "setting up my flake";

  inputs.home-manager.url = "github:nix-community/home-manager";
 
   outputs = { self, nix-homebrew, home-manager }: {

     packages.aarch64-darwin.hello = nixpkgs.legacyPackages.aarch64-darwin.hello;
    };
   
  in {
    darwinConfigurations = let
      inherit (inputs.nix-darwin.lib) darwinSystem;
    in {
      bettrere = darwinSystem {
        system = "aarch64-darwin";
 
        specialArgs = { inherit inputs; };
 
        modules = [
          ./hosts/mbp/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
 
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.noghartt = import ./home/home.nix;
          }
        ];
      };
    };
  };
}
