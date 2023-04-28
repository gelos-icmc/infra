{
  inputs,
  pkgs,
  config,
  ...
}: {
  # ===
  # TODO: https://github.com/NixOS/nixpkgs/pull/228002
  imports = [
    "${inputs.nixpkgs-pr-228002}/nixos/modules/services/web-apps/kavita.nix"
  ];
  nixpkgs.overlays = [
    (final: prev: {
      kavita = inputs.nixpkgs-pr-228002.legacyPackages.${pkgs.system}.kavita;
    })
  ];
  # ===

  services.kavita = {
    enable = true;
    port = 5002;
    tokenKeyFile = config.sops.secrets.kavita-secret.path;
  };
  services.nginx = {
    virtualHosts = {
      "kavita.gelos.club" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://127.0.0.1:${toString config.services.kavita.port}";
      };
    };
  };

  sops.secrets.kavita-secret = {
    owner = "kavita";
    group = "kavita";
    sopsFile = ../secrets.yml;
  };
}
