{
  imports = [
    ./hardware-configuration.nix
    ../common/server

    ./gelos-forms-backend.nix # Serviço pra submeter form de registro no grupo
    ./jitsi.nix # Video conferências
    ./nginx.nix # Proxy reverso pra todas as aplicações web
  ];

  networking = {
    nameservers = [ "143.107.253.3" ];
    interfaces = {
      # Interface WAN
      # Conectada a internet da USP, IP estatico
      eno1 = {
        useDHCP = false;
        ipv4 = {
          addresses = [{
            address = "143.107.183.251";
            prefixLength = 26;
          }];
          routes = [{
            address = "0.0.0.0";
            prefixLength = 0;
            via = "143.107.183.193";
          }];
        };
      };
    };
  };
}
