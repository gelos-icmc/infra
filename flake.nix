{
  description = "You new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    hardware.url = "github:nixos/nixos-hardware";

    # Projetos nixificados
    gelos-forms.url = "gitlab:gelos-icmc/formsbackend";
    gelos-forms.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      inherit (inputs.utils.lib) eachSystemMap defaultSystems;
      inherit (inputs.nixpkgs.lib) nixosSystem;
      eachDefaultSystemMap = eachSystemMap defaultSystems;
      mkConfiguration = { hostname, system ? "x86_64-linux", overlays }: nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostname}
          # Aplicar overlays
          { nixpkgs.overlays = builtins.attrValues overlays; }
        ];
        specialArgs = { inherit inputs hostname; };
      };
    in
    rec {
      # Adicionar pacotes exportados por outros flakes
      overlays = {
        gelos-forms = inputs.gelos-forms.overlays.default;
      };

      nixosConfigurations = {
        emperor = mkConfiguration {
          hostname = "emperor";
          inherit overlays;
        };
        galapagos = mkConfiguration {
          hostname = "galapagos";
          inherit overlays;
        };
        macaroni = mkConfiguration {
          hostname = "macaroni";
          inherit overlays;
        };
        rockhopper = mkConfiguration {
          hostname = "rockhopper";
          inherit overlays;
        };
      };

      devShells = eachDefaultSystemMap (system: {
        default = import ./shell.nix { pkgs = import inputs.nixpkgs { inherit system; }; };
      });
    };
}
