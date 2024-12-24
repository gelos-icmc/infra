{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "949753cf85edc903ab777725cbcc215d1bc05f50";
  url = "https://github.com/gelos-icmc/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-NFFXw2Gy8gnq556GYhmFzEmtK8bzxHC/00in+ZwH6Tg=";
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
