{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "d4d74bcc94050fddfd9461422d4d255ab5359f69";
  url = "https://github.com/gelos-icmc/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-I3dr4Lddx/X950uq667v3t2jQdo7CY/+nLjTZBg97GI=";
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
      jvmOpts = "-Xms1G -Xmx8G -XX:+UseParallelGC";
    };
  };
}
