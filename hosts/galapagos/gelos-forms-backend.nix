{ inputs, ... }:
{
  imports = [
    inputs.gelos-forms-backend.nixosModules.default
  ];

  services.gelos-forms-backend.enable = true;
}
