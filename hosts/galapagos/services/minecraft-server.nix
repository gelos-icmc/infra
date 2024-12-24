{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "0de5f7ed44917527bff4379b1c301f1e36825ff7";
  url = "https://github.com/gelos-icmc/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-beUVd3J+sx2bnBMJ3E9ItFfm9zXZfF3PChhQ3PFX0LE=";
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
