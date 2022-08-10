{ config, ... }:
{
  services = {
    onlyoffice = {
      enable = true;
      hostname = "onlyoffice.gelos.club";
      # Autenticação via unix socket
      postgresName = "onlyoffice";
      postgresUser = "onlyoffice";
      port = 8001;
      jwtSecretFile = config.sops.secrets.onlyoffice-secret.path;
      # Exemplo
      examplePort = 8002;
      enableExampleServer = true;
    };
    postgresql = {
      ensureDatabases = [ "onlyoffice" ];
      ensureUsers = [{
        name = "onlyoffice";
        ensurePermissions = { "DATABASE onlyoffice" = "ALL PRIVILEGES"; };
      }];
    };

    nginx.virtualHosts = {
      "onlyoffice.gelos.club" = {
        forceSSL = true;
        enableACME = true;
      };
    };
  };

  users.groups.onlyoffice = {
    members = [ "nginx" "nextcloud" ];
  };

  sops.secrets.onlyoffice-secret = {
    owner = "onlyoffice";
    group = "onlyoffice";
    sopsFile = ../secrets.yml;
  };
}
