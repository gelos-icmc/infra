{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "5aa7c03";
  url = "https://github.com/gelos-icmc/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-QqeCfjOcu5SmuiImJszQ7ohOeTJ+AdCpapAgmTSgUb0=";
};

in {

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.GELOS-server = {
      enable = true;
      whitelist = import ./minecraft-whitelist.nix;
      package = pkgs.forgeServers.forge-1_20_1;
      serverProperties = {
        server-port = 25565;
        online-mode = true;
        allow-flight = true;
      };
      symlinks = {
        "mods" = "${modpack}/mods";
      };
      jvmOpts = "-Xms1G -Xmx8G";
    };
  };
}
