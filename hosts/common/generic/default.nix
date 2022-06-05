{ pkgs, inputs, hostname, lib, ... }:
let
  inherit (lib) mkDefault nameValuePair mapAttrs';
in
{
  imports = [ ../../../users ./sops.nix ];

  networking.hostName = hostname;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };
  nix = {
    registry = mapAttrs' (name: flake: nameValuePair name { inherit flake; }) inputs;
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

  services = {
    openssh = {
      enable = true;
      # Endurecer o SSH, absolutamente essencial
      passwordAuthentication = false;
      permitRootLogin = "no";
      # TODO: Pedir pro STI abrir a porta 22 pra quem ta dentro da USP
      ports = [ 2112 ];
    };
  };

  time.timeZone = "America/Sao_Paulo";
  system.stateVersion = "21.11";
}
