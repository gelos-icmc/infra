{ config, ... }:
{
  services = {
    plausible = {
      enable = true;
      adminUser = {
        activate = true;
        email = "contato@gelos.club";
        name = "admin";
        passwordFile = config.sops.secrets.plausible-admin-password.path;
      };
      mail = {
        email = "social@gelos.club";
        smtp = {
          hostAddr = "mail.gandi.net";
          hostPort = 465;
          enableSSL = true;
          passwordFile = config.sops.secrets.plausible-smtp-password.path;
          user = "social@gelos.club";
        };
      };
      server = {
        baseUrl = "https://analytics.gelos.club";
        disableRegistration = true;
        secretKeybaseFile = config.sops.secrets.plausible-secret-key.path;
      };
      releaseCookiePath = config.sops.secrets.plausible-secret-key.path;
    };
    nginx.virtualHosts = {
      "analytics.gelos.club" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass =
          "http://127.0.0.1:${toString config.services.plausible.server.port}";
      };
    };
  };

  sops.secrets = {
    plausible-admin-password.sopsFile = ../secrets.yml;
    plausible-smtp-password.sopsFile = ../secrets.yml;
    plausible-secret-key.sopsFile = ../secrets.yml;
  };
}
