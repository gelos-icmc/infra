{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/gnome.nix
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-hdd
  ];

  networking.networkmanager.enable = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
