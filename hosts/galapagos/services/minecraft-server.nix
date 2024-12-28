{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "53fc8bb77a9aa7e5a89e28c8fa2ac54678447d26";
  url = "https://github.com/gelos-icmc/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-/w0a/+PrFXwyNvfL4E+keILFPafon8UmPoLz4QNEv7I=";
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
      enableReload = true;
    };
  };
}
