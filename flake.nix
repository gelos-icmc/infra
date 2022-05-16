{
  description = "Config dos computadores do GELOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    hardware.url = "github:nixos/nixos-hardware";
    deploy-rs.url = "github:serokell/deploy-rs";

    # Projetos nixificados
    gelos-forms.url = "gitlab:gelos-icmc/formsbackend/1.0.1";
    gelos-forms.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      lib = import ./lib { inherit inputs; };
      inherit (lib) mkConfiguration mkDeploy eachSystem;
    in
    rec {
      # Adicionar pacotes exportados por outros flakes
      overlays = rec {
        gelos-forms = inputs.gelos-forms.overlays.default;
        deploy-rs = inputs.deploy-rs.overlay;
      };

      # nixos-rebuild
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

      # deploy
      deploy.nodes = {
        galapagos = mkDeploy nixosConfigurations.galapagos // {
          hostname = "galapagos.gelos.club";
          sshOpts = [ "-p" "2112" ];
        };
      };

      # nix develop
      devShells = eachSystem (system: {
        default = import ./shell.nix {
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = builtins.attrValues overlays;
          };
        };
      });

      # nix build
      packages = eachSystem (system: rec {
        inherit (inputs.deploy-rs.packages.${system}) deploy-rs;
      });

      # nix run
      apps = eachSystem (system: rec {
        deploy-rs = {
          type = "app";
          program = "${packages.${system}.deploy-rs}/bin/deploy";
        };
      });
    };
}
