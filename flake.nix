{
  description = "You new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }@inputs:
    let
      inherit (utils.lib) eachSystemMap defaultSystems;
      inherit (nixpkgs.lib) nixosSystem;
      eachDefaultSystemMap = eachSystemMap defaultSystems;
      mkConfiguration = { hostname, system ? "x86_64-linux" }: nixosSystem {
        inherit system;
        modules = [ ./hosts/${hostname} ];
        specialArgs = { inherit inputs hostname; };
      };
    in
    rec {
      nixosConfigurations = {
        emperor = mkConfiguration {
          hostname = "emperor";
        };
        galapagos = mkConfiguration {
          hostname = "galapagos";
        };
        macaroni = mkConfiguration {
          hostname = "macaroni";
        };
        rockhopper = mkConfiguration {
          hostname = "rockhopper";
        };
      };

      devShells = eachDefaultSystemMap (system: {
        default = import ./shell.nix { pkgs = import nixpkgs { inherit system; }; };
      });
    };
}
