{
  inputs,
  pkgs,
  ...
}: let
  mainPkg = flake: flake.packages.${pkgs.system}.default;
  minutes = n: toString (n * 60);
  days = n: toString (n * 60 * 60 * 24);
in {
  services.nginx.virtualHosts = {
    "gelos.club" = {
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
          alias = "${mainPkg inputs.gelos-identidade-visual}/";
        };

        # Permalinks mais curtinhos, geralmente usados pra QRs
        "=/debian-day".return = "301 https://gelos.club/2023/08/02/debian-day.html";
        # TODO: apontar pra um blog post quando estiver pronto
        "=/installfest-4".return = "301 https://gelos.club/projetos/installfest-2023-2.html";
      };
    };
    "gelos.icmc.usp.br" = {
      forceSSL = true;
      enableACME = true;
      locations."/".return = "302 https://gelos.club$request_uri";
    };
    "galapagos.gelos.icmc.usp.br" = {
      forceSSL = true;
      enableACME = true;
      locations."/".return = "302 https://gelos.club$request_uri";
    };
  };
}
