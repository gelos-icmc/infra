{ inputs, pkgs, ... }:
let
  lastModified = flake: convertDateTime flake.lastModified;
  convertDateTime = timestamp: builtins.readFile (
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
    locations = {
      "/" = {
        alias = "${pkgs.gelos-site}/public/";
        # Adicionar header indicando data de modificação
        # Pra permitir que o navegador cacheie
        extraConfig = ''
          add_header Last-Modified "${lastModified inputs.gelos-site}";
        '';
      };
      "=/identidade" = {
        return = "301 https://gelos.club/identidade/";
      };
      "/identidade/" = {
        alias = "${pkgs.gelos-identidade-visual}/";
        # Adicionar header indicando data de modificação
        # Pra permitir que o navegador cacheie
        extraConfig = ''
          add_header Last-Modified "${lastModified inputs.gelos-identidade-visual}";
        '';
      };
    };
  };
}
