{
  inputs,
  pkgs,
  ...
}: let
  mainPkg = flake: flake.packages.${pkgs.system}.default;
  minutes = n: toString (n * 60);
  days = n: toString (n * 60 * 60 * 24);
in {
  services.nginx.virtualHosts."gelos.club" = {
    default = true;
    forceSSL = true;
    enableACME = true;
    locations = {
      "/" = {
        root = "${mainPkg inputs.gelos-site}/public";
        extraConfig = ''
          add_header Cache-Control "stale-while-revalidate=${minutes 5}";
        '';
      };
      "/assets/" = {
        root = "${mainPkg inputs.gelos-site}/public";
        extraConfig = ''
          add_header Cache-Control "max-age=${days 1}, stale-while-revalidate=${days 30}";
        '';
      };
      "=/identidade" = {
        return = "301 https://gelos.club/identidade/";
      };
      "/identidade/" = {
        root = "${mainPkg inputs.gelos-identidade-visual}/";
      };
    };
  };
}
