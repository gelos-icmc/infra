{ inputs }:
let
  inherit (inputs.utils.lib) eachSystemMap defaultSystems;
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (builtins) attrValues;
in
{
  eachSystem = eachSystemMap defaultSystems;

  mkConfiguration = { hostname, system ? "x86_64-linux", overlays }: nixosSystem {
    inherit system;
    modules = [
      ../hosts/${hostname}
      # Aplicar overlays
      { nixpkgs.overlays = attrValues overlays; }
    ];
    specialArgs = { inherit inputs hostname; };
  };

  mkDeploy = config: {
    profiles.system = {
      user = "root";
      path = inputs.deploy-rs.lib.${config.pkgs.system}.activate.nixos config;
    };
  };
}
