{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./default.nix
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  networking.networkmanager.enable = true;
  networking.networkmanager.ethernet.macAddress = "permanent"; # use real Mac address
  networking.networkmanager.wifi.macAddress = "permanent";


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
    pkgs.curl
    pkgs.kdePackages.kate
  ];

  # Flatpaks
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "com.valvesoftware.SteamLink"
  ];

  # Zsh
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
     enable = true;
     enableCompletion = true;
     autosuggestions.enable = true;
     syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "agnoster";
    };
  };

  # Sudo
  security.sudo = {
  enable = true;
  extraRules = [{
    commands = [
      {
        command = "${pkgs.systemd}/bin/reboot";
        options = [ "NOPASSWD" ];
      }
      {
        command = "${pkgs.systemd}/bin/poweroff";
        options = [ "NOPASSWD" ];
      }
    ];
    groups = [ "wheel" ];
  }];
  extraConfig = with pkgs; ''
    Defaults        lecture = always
  '';
};

  system.stateVersion = "24.05"; # Did you read the comment?

}
