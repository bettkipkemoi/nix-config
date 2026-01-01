{
  description = "setting up my flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs: let
    nix_darwin = inputs."nix-darwin";
    home_manager = inputs."home-manager";
    darwinSystem = nix_darwin.lib.darwinSystem;
  in {
    packages.aarch64-darwin.hello = inputs.nixpkgs.legacyPackages.aarch64-darwin.hello;

    darwinConfigurations = {
      bettrere = darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ( { }: { services.nix-daemon.enable = true; } )
        ];
      };
    };
  };
}
