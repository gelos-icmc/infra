{ config, ... }:
{
  nixpkgs.overlays = [(final: prev: {
    # TODO: move to services.matterbridge.package when https://github.com/NixOS/nixpkgs/pull/340180 is available
    matterbridge = prev.matterbridge.overrideAttrs (_: {
      version = "unstable-2024-08-27";
      src = final.fetchFromGitHub {
        owner = "42wim";
        repo = "matterbridge";
        rev = "c4157a4d5b49fce79c80a30730dc7c404bacd663";
        hash = "sha256-ZnNVDlrkZd/I0NWmQMZzJ3RIruH0ARoVKJ4EyYVdMiw=";
      };
    });
  })];

  services.matterbridge = {
    enable = true;
    configPath = config.sops.templates."matterbridge".path;
  };

  sops.secrets = {
    matterbridge-telegram.sopsFile = ../secrets.yml;
    matterbridge-matrix.sopsFile = ../secrets.yml;
    matterbridge-discord.sopsFile = ../secrets.yml;
  };
  sops.templates."matterbridge" = {
    owner = config.services.matterbridge.user;
    group = config.services.matterbridge.group;
    content = /* toml */ ''
      [telegram.gelos]
      Token="${config.sops.placeholder.matterbridge-telegram}"
      RemoteNickFormat="\\<*{NICK}*\\@{PROTOCOL}\\>: "
      MessageFormat="MarkdownV2"
      PreserveThreading=true
      QuoteFormat="{MESSAGE}"
      UseFirstName=true
      [matrix.gelos]
      Server="https://matrix.org"
      Login="bot-teste-matrix"
      Password="${config.sops.placeholder.matterbridge-matrix}"
      PreserveThreading=true
      QuoteFormat="{MESSAGE}"
      RemoteNickFormat="<{NICK}@{PROTOCOL}> "
      NoHomeServerSuffix=false
      UseUsername=false
      [discord.gelos]
      Token="${config.sops.placeholder.matterbridge-discord}"
      Server="1284533922578960404"
      AutoWebhooks=true
      RemoteNickFormat="<{NICK}@{PROTOCOL}> "
      PreserveThreading=true
      UseLocalAvatar=["telegram"]

      [[gateway]]
      name="geral"
      enable=true
      [[gateway.inout]]
      account="telegram.gelos"
      channel="-1001671420611"
      [[gateway.inout]]
      account="matrix.gelos"
      channel="#gelos-geral:matrix.org"

      [[gateway]]
      name="offtopic"
      enable=true
      [[gateway.inout]]
      account="telegram.gelos"
      channel="-1001671420611/34225"
      [[gateway.inout]]
      account="matrix.gelos"
      channel="#gelos-offtopic:matrix.org"
      [[gateway.inout]]
      account="discord.gelos"
      channel="off-topic"

      [[gateway]]
      name="suporte"
      enable=true
      [[gateway.inout]]
      account="telegram.gelos"
      channel="-1001671420611/35728"
      [[gateway.inout]]
      account="matrix.gelos"
      channel="#gelos-suporte:matrix.org"

      [[gateway]]
      name="installfest"
      enable=true
      [[gateway.inout]]
      account="telegram.gelos"
      channel="-1001671420611/34212"
      [[gateway.inout]]
      account="matrix.gelos"
      channel="#gelos-installfest:matrix.org"

      [[gateway]]
      name="nix"
      enable=true
      [[gateway.inout]]
      account="telegram.gelos"
      channel="-1001671420611/69543"
      [[gateway.inout]]
      account="matrix.gelos"
      channel="#gelos-nix:matrix.org"

      [[gateway]]
      name="linuxgaming"
      enable=true
      [[gateway.inout]]
      account="telegram.gelos"
      channel="-1001671420611/103504"
      [[gateway.inout]]
      account="matrix.gelos"
      channel="#gelos-linuxgaming:matrix.org"

      [[gateway]]
      name="reunioes"
      enable=true
      [[gateway.inout]]
      account="telegram.gelos"
      channel="-1001671420611/47679"
      [[gateway.inout]]
      account="matrix.gelos"
      channel="#gelos-reunioes:matrix.org"
    '';
  };
}
