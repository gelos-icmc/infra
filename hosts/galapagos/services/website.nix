{
  inputs,
  pkgs,
  ...
}: let
  mainPkg = flake: flakePkg flake "default";
  flakePkg = flake: name: flake.packages.${pkgs.system}.${name};
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
            # Antigo link de atas
            rewrite ^/([0-9]+)/([0-9]+)/([0-9]+)/ata\.html$ /reunioes/$1-$2-$3.html permanent;

            # Redirecionar pdfs pra atas.gelos.club
            rewrite ^/reunioes/(.*\.pdf)$ https://atas.gelos.club/$1 temporary;
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
        "=/installfest-4".return = "301 https://gelos.club/2023/08/21/installfest-2023-2.html";
        "=/if4".return = "301 https://gelos.club/2023/08/21/installfest-2023-2.html";
        "=/installfest-5".return = "301 https://gelos.club/2024/03/01/installfest-2024-1.html";
        "=/if5".return = "301 https://gelos.club/2024/03/01/installfest-2024-1.html";
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

    "atas.gelos.club" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        root = "${flakePkg inputs.gelos-site "atas"}";
        extraConfig = ''
          add_header Cache-Control "max-age=${minutes 15}";
          # Redirecionar htmls pra gelos.club/reunioes
          rewrite ^(.*\.html)$ https://gelos.club/reunioes/$1 temporary;
        '';
      };
    };

    "telegram.gelos.club" = {
      forceSSL = true;
      enableACME = true;
      locations."/".return = "302 https://t.me/gelos_geral";
    };
    "matrix.gelos.club" = {
      forceSSL = true;
      enableACME = true;
      locations."/".return = "302 https://matrix.to/#/#gelos:matrix.org";
    };
    "youtube.gelos.club" = {
      forceSSL = true;
      enableACME = true;
      locations."/".return = "302 https://www.youtube.com/@gelos3943";
    };
  };

  services.agate = {
    enable = true;
    hostnames = [ "gelos.club" "gelos.icmc.usp.br" ];
    contentDir = pkgs.writeTextDir "index.gmi" ''
      Site apenas disponível na web:
      => https://gelos.club
    '';
  };
  networking.firewall.allowedTCPPorts = [ 1965 ];
}
