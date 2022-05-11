{ inputs, config, ... }:
{
  imports = [
    inputs.gelos-forms-backend.nixosModules.default
  ];

  services = {
    # Habilitar serviço
    # Fácil né
    gelos-forms-backend.enable = true;

    # Proxy reverso, com HTTPS automático pelo lets encrypt
    nginx.virtualHosts."join.gelos.club" = {
      forceSSL = true;
      enableACME = true;
      locations."/".proxyPass = "http://localhost:${toString config.services.gelos-forms-backend.port}";
    };
  };
}
