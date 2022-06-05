{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/desktop
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-hdd
  ];
}
