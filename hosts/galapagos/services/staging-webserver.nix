{ config, ... }:
{
  # VHost do nginx para servir coisas tipo previews de PRs

  services.nginx.virtualHosts."staging.gelos.club" = {
    enableACME = true;
    forceSSL = true;
    root = "/srv/staging";
  };

  users = {
    users.staging = {
      home = "/srv/staging";
      createHome = true;
      homeMode = "755";
      isSystemUser = true;
      group = "staging";
      # TODO: fazer esse usuário ter chave própria
      openssh.authorizedKeys.keys =
        config.users.users.admin.openssh.authorizedKeys.keys;
    };
    groups.staging = { };
  };
}
