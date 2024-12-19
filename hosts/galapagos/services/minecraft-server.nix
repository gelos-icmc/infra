{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "bbf0b48";
  url = "https://github.com/ViniciusDMSantos/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-EGcpkyhwescLe8VMXCFqI94FrRLvYUmsqAhFaQZvv20=";
};

in {

  services = {
    minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
      servers.GELOS-server = {
        enable = true;

        package = pkgs.forgeServers.forge-1_20_1;
        serverProperties = {
          server-port = 25572;
          online-mode = true;
        };

        jvmOpts = "-Xms1G -Xmx4G";
      };
    };
    nginx.virtualHosts."minecraft.gelos.club" = {
      locations."/".proxyPass = "http://localhost:25572";
    };
  };
}
