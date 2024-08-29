{
  imports = [
    ../common/desktop
    ../common/users
    ./hardware-configuration.nix
  ];

  networking.hostName = "macaroni";
  system.stateVersion = "24.05"; # NÃO mudar sem antes migrar estado
}
