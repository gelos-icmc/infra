{
  inputs,
  pkgs,
  lib,
  ...
}: let
modpack = pkgs.fetchPackwizModpack rec {
  version = "b3853cd1aa32b3b56b16cc01d967f920ddd8f37d";
  url = "https://github.com/gelos-icmc/Icepack/raw/${version}/pack.toml";
  packHash = "sha256-f4Kz4+ZqtWGhYy8pVs+nlbhlUH5Zn3cVFDa7cRgO8eQ=";
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
      jvmOpts = "-Xms1G -Xmx6G -XX:+UseParallelGC";
    };
  };
}
