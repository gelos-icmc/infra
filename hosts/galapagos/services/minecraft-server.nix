{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "ee3196f109f90eeb8cf28c1ca85682134422e28d";
  url = "https://github.com/gelos-icmc/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-FQZFQEHniTMkJN0MXEry/Rf0qKAUuN40BFQ6y64n8HQ=";
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
        spawn-protection = 0;
        server-port = 25565;
        online-mode = true;
        max-tick-time = 300000;
        allow-flight = true;
      };
      symlinks = {
        "mods" = "${modpack}/mods";
      };
      files = {
        "config" = "${modpack}/config";
      };
      jvmOpts = "-Xms1G -Xmx8G -XX:+UseParallelGC";
    };
  };
}
