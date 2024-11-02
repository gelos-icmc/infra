{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../global
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  networking.networkmanager.enable = true;

  i18n.defaultLocale = "pt_BR.UTF-8";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  console.keyMap = "br-abnt2";

  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs = {
    firefox.enable = true;
    neovim.enable = true;
  };
  environment.systemPackages = [
    pkgs.kdePackages.kate
  ];

  # Flatpaks
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;
  services.flatpak = {
    enable = true;
    packages = [
      "com.valvesoftware.SteamLink"
    ];
  };

  # Zsh
  environment.shells = [pkgs.zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = ["git"];
      theme = "agnoster";
    };
  };

  # Sudo
  security.sudo = {
    extraConfig = ''
      Defaults        lecture = always
    '';
  };
}
