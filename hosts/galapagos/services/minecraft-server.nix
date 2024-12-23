{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "5e4bf314b0356c0710f6d85a8fd5b6842cfd54f8";
  url = "https://github.com/gelos-icmc/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-qbnBdWFZZ7xzRCfq2LkJaF+U0BTU1RcoGucdrNyWS5M=";
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
        white-list = true;
        server-port = 25565;
        online-mode = true;
        allow-flight = true;
      };
      symlinks = {
        "mods" = "${modpack}/mods";
      };
      jvmOpts = "-Xms1G -Xmx8G -XX:+UseParallelGC";
    };
  };
}
