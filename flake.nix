{
  description = "Infraestrutura principal para serviços hospedados pelo GELOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    gelos-site = {
      url = "github:gelos-icmc/site";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gelos-identidade-visual = {
      url = "github:gelos-icmc/identidade-visual";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gelos-forms = {
      url = "gitlab:gelos-icmc/formsbackend/1.0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, utils, ... }@inputs: rec {
    # Overlays, adicionam ou alteram pacotes do nixpkgs
    overlays = {
      gelos-site = inputs.gelos-site.overlays.default;
      gelos-identidade-visual = inputs.gelos-identidade-visual.overlays.default;
      gelos-forms = inputs.gelos-forms.overlays.default;
    };

    # Reexportar pacotes do nixpkgs com as overlays aplicadas
    legacyPackages = utils.lib.eachDefaultSystemMap (system:
      import nixpkgs {
        inherit system;
        overlays = builtins.attrValues overlays;
        config.allowUnfree = true;
      }
    );

    # Configuração da máquina
    # Acessível por 'nixos-rebuild --flake .#galapagos'
    nixosConfigurations = {
      galapagos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = legacyPackages.${system};
        modules = [ ./hosts/galapagos/configuration.nix ];
        specialArgs = { inherit inputs; };
      };
    };

    # Configuração do deploy-rs
    # Explica o que dar deploy, e pra onde
    deploy.nodes =
      let
        activate = kind: config: inputs.deploy-rs.lib.${config.pkgs.system}.activate.${kind} config;
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
      };

    # Permite rodar 'nix run .#deploy' ou apenas 'nix run' para fazer deploy
    apps = utils.lib.eachDefaultSystemMap (system: rec {
      deploy = {
        type = "app";
        program = "${legacyPackages.${system}.deploy-rs}/bin/deploy";
      };
      default = deploy;
    });

  };
}
