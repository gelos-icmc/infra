{ pkgs, ... }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # Tooling no repo
    nix
    git

    # Para deploy
    ssh-to-pgp
    gnupg
    age
    deploy-rs.deploy-rs
    sops

    # Para importar chaves publicas automagicamente
    sops-import-keys-hook
  ];
  sopsPGPKey = [
    "./users/misterio/pubkey.asc"
  ];
}
