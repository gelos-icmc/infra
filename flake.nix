{
  description = "Infraestrutura principal para serviços hospedados pelo GELOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    utils.url = "github:numtide/flake-utils";
    hardware.url = "github:nixos/nixos-hardware";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Projetos nixificados
    gelos-site.url = "github:gelos-icmc/site";
    gelos-identidade-visual.url = "github:gelos-icmc/identidade-visual";
  };

  outputs = { nixpkgs, utils, ... }@inputs: rec {
    # Configuração da máquina
    # Acessível por 'nixos-rebuild --flake .#galapagos'
    nixosConfigurations = {
      galapagos = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/galapagos/configuration.nix ];
        specialArgs = { inherit inputs; };
      };
      emperor = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/emperor/configuration.nix ];
        specialArgs = { inherit inputs; };
      };
    };

    # Configuração do deploy-rs
    # Explica o que dar deploy, e pra onde
    deploy.nodes =
      let activate = kind: config: inputs.deploy-rs.lib.${config.pkgs.system}.activate.${kind} config;
      in
      {
        galapagos = {
          hostname = "galapagos.gelos.club";
          sshUser = "admin";
          sshOpts = [ "-p" "2112" ];
          profiles.system = {
            user = "root";
            path = activate "nixos" nixosConfigurations.galapagos;
          };
        };
        emperor = {
          hostname = "emperor.gelos.club";
          sshUser = "admin";
          sshOpts = [ "-p" "2112" ];
          profiles.system = {
            user = "root";
            path = activate "nixos" nixosConfigurations.emperor;
          };
        };
      };

    # Permite rodar 'nix run .#deploy' ou apenas 'nix run' para fazer deploy
    apps = utils.lib.eachDefaultSystemMap (system: rec {
      deploy = {
        type = "app";
        program = "${nixpkgs.legacyPackages.${system}.deploy-rs}/bin/deploy";
      };
      default = deploy;
    });

    nixConfig = {
      extra-substituers = [ "https://gelos-icmc.cachix.org" ];
      extra-trusted-public-keys = [ "gelos-icmc.cachix.org-1:IQxtwf+SS2LUWWoPgzYQMAYUvsBA+7tdooE42KRcCWk=" ];
    };
  };
}
