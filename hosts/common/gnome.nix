{
  programs = {
    gnome-terminal.enable = true;
  };
  services.xserver = {
    enable = true;
    desktopManager.gnome = {
      enable = true;
    };
    displayManager.gdm = {
      enable = true;
    };
    libinput.enable = true;
  };
}
