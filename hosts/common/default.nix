{ pkgs, inputs, hostname, lib, ... }:
let
  inherit (lib) mapAttrs' nameValuePair mkDefault;
in
{
  imports = [ ../../users.nix ];

  networking.hostName = hostname;

  nixpkgs = {
    config.allowUnfree = true;
  };
  nix = {
    registry = inputs;
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = mkDefault true;
      dates = mkDefault "weekly";
    };
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://misterio.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "misterio.cachix.org-1:cURMcHBuaSihTQ4/rhYmTwbbfWO8AnZEu6w4aNs3iKE="
      ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "pt_BR.UTF-8";
    };
  };
  time.timeZone = mkDefault "America/Sao_Paulo";
}
