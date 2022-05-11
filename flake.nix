{
  description = "You new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    hardware.url = "github:nixos/nixos-hardware";

    # Projetos nixificados
    gelos-forms-backend.url = "gitlab:gelos-icmc/formsbackend/empacotamento";
    gelos-forms-backend.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      inherit (inputs.utils.lib) eachSystemMap defaultSystems;
      inherit (inputs.nixpkgs.lib) nixosSystem;
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
        default = import ./shell.nix { pkgs = import inputs.nixpkgs { inherit system; }; };
      });
    };
}
