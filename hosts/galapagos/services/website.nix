{ inputs, pkgs, ... }:
let
  toDateTime = timestamp: builtins.readFile (
    pkgs.runCommandLocal "datetime" { } ''
      dt="$(date -Ru -d @${toString timestamp})"
      echo -n ''${dt/+0000/GMT} > $out
    ''
  );
in
{
  services.nginx.virtualHosts."gelos.club" = {
    default = true;
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      root = "${pkgs.gelos-site}/public";
      # Adicionar header indicando data de modificação
      # Pra permitir que o navegador cacheie
      extraConfig = ''
        add_header Last-Modified "${toDateTime inputs.gelos-site.lastModified}";
      '';
    };
  };
}
