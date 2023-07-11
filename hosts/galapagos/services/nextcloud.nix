{
  config,
  pkgs,
  ...
}: let
  hostName = "cloud.gelos.club";
in {
  services = {
    nextcloud = {
      inherit hostName;
      package = pkgs.nextcloud26;
      enable = true;
      https = true;
      home = "/media/nextcloud";
      enableBrokenCiphersForSSE = false;
      config = {
        adminpassFile = config.sops.secrets.nextcloud-password.path;
        dbhost = "/run/postgresql";
        dbtype = "pgsql";
      };
    };
    postgresql = {
      ensureDatabases = ["nextcloud"];
      ensureUsers = [
        {
          name = "nextcloud";
          ensurePermissions = {"DATABASE nextcloud" = "ALL PRIVILEGES";};
        }
      ];
    };

    nginx.virtualHosts.${hostName} = {
      forceSSL = true;
      enableACME = true;
    };
  };

  sops.secrets.nextcloud-password = {
    owner = "nextcloud";
    group = "nextcloud";
    sopsFile = ../secrets.yml;
  };
}
