{
  description = "Infraestrutura principal para serviços hospedados pelo GELOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
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
    gelos-site = {
      url = "github:gelos-icmc/site";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gelos-identidade-visual = {
      url = "github:gelos-icmc/identidade-visual";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
  in rec {
    # Configuração da máquina
    # Acessível por 'nixos-rebuild --flake .#galapagos'
    nixosConfigurations = {
      galapagos = nixpkgs.lib.nixosSystem {
        modules = [./hosts/galapagos/configuration.nix];
        specialArgs = {inherit inputs outputs;};
      };
      emperor = nixpkgs.lib.nixosSystem {
        modules = [./hosts/emperor/configuration.nix];
        specialArgs = {inherit inputs outputs;};
      };
    };

    # Configuração do deploy-rs
    # Explica o que dar deploy, e pra onde
    deploy.nodes = let
      activate = kind: config: inputs.deploy-rs.lib.${config.pkgs.system}.activate.${kind} config;
    in {
      galapagos = {
        hostname = "galapagos.gelos.club";
        sshUser = "admin";
        sshOpts = ["-p" "2112"];
        profiles.system = {
          user = "root";
          path = activate "nixos" nixosConfigurations.galapagos;
        };
      };
      emperor = {
        hostname = "emperor.gelos.club";
        sshUser = "admin";
        sshOpts = ["-p" "2112"];
        profiles.system = {
          user = "root";
          path = activate "nixos" nixosConfigurations.emperor;
        };
      };
    };

    # Permite rodar 'nix run .#deploy' ou apenas 'nix run' para fazer deploy
    apps = forAllSystems (system: rec {
      deploy = {
        type = "app";
        program = "${nixpkgs.legacyPackages.${system}.deploy-rs}/bin/deploy";
      };
      default = deploy;
    });

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  nixConfig = {
    extra-substituers = ["https://gelos-icmc.cachix.org"];
    extra-trusted-public-keys = ["gelos-icmc.cachix.org-1:IQxtwf+SS2LUWWoPgzYQMAYUvsBA+7tdooE42KRcCWk="];
  };
}
