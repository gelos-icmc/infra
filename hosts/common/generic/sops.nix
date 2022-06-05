{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    # Importar segredos encriptados do repositório
    defaultSopsFile = ../../../secrets/main.yml;
    # Desencriptar com a chave privada SSH do host do servidor
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };
}
