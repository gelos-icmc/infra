{
  description = "You new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    hardware.url = "github:nixos/nixos-hardware";
    deploy-rs.url = "github:serokell/deploy-rs";

    # Projetos nixificados
    gelos-forms.url = "gitlab:gelos-icmc/formsbackend/1.0.0";
    gelos-forms.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { utils, nixpkgs, deploy-rs, ... }@inputs:
    let
      inherit (utils.lib) eachSystemMap defaultSystems;
      inherit (nixpkgs.lib) nixosSystem;
      inherit (builtins) attrValues;

      eachDefaultSystemMap = eachSystemMap defaultSystems;
      mkConfiguration = { hostname, system ? "x86_64-linux", overlays }: nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostname}
          # Aplicar overlays
          { nixpkgs.overlays = attrValues overlays; }
        ];
        specialArgs = { inherit inputs hostname; };
      };
      mkDeploy = config: {
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.${config.pkgs.system}.activate.nixos config;
        };
      };
    in
    rec {
      # Adicionar pacotes exportados por outros flakes
      overlays = {
        gelos-forms = inputs.gelos-forms.overlays.default;
        deploy-rs = inputs.deploy-rs.overlay;
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

      deploy.nodes = {
        galapagos = mkDeploy nixosConfigurations.galapagos // {
          hostname = "galapagos.gelos.club";
          sshOpts = [ "-p" "2112" ];
        };
      };

      devShells = eachDefaultSystemMap (system: {
        default = import ./shell.nix { pkgs = import nixpkgs { inherit system; overlays = attrValues overlays; }; };
      });
    };
}
