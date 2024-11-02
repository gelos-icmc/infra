{
  imports = [
    ../common/desktop
    ../common/users
    ./hardware-configuration.nix
  ];

  networking.hostName = "rockhopper";
  system.stateVersion = "24.05"; # NÃO mudar sem antes migrar estado
}
