{ inputs, config, ... }:
{
  imports = [
    inputs.gelos-forms.nixosModules.default
  ];

  services = {
    gelos-forms = {
      enable = true;
      database.type = "postgres";
    };

    # Proxy reverso, com HTTPS automático pelo lets encrypt
    nginx.virtualHosts."join.gelos.club" = {
      forceSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.gelos-forms.port}";
    };
  };
}
