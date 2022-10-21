{ inputs, pkgs, ... }:
let
  mainPkg = flake: flake.packages.${pkgs.system}.default;
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
        alias = "${mainPkg inputs.gelos-site}/public/";
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
        alias = "${mainPkg inputs.gelos-identidade-visual}/";
        # Adicionar header indicando data de modificação
        # Pra permitir que o navegador cacheie
        extraConfig = ''
          add_header Last-Modified "${lastModified inputs.gelos-identidade-visual}";
        '';
      };
    };
  };
}
