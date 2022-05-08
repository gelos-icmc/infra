# Laboratório GELOS - Configurações

Configurações em Nix dos computadores do laboratório da linda sala do GELOS.

## Como usar as configs existentes
Sendo `nome-do-pc` um de:

- `emperor`: Servidor principal
- `galapagos`: Servidor secundário
- `macaroni`: All-in-one 1
- `rockhopper`: All-in-one 2 (no momento com pouca RAM)

Basta usar:
```bash
sudo nixos-rebuild switch --flake gitlab:gelos-icmc/lab-config#nome-do-pc
```
Ou:
```bash
git clone https://gitlab.com/gelos-icmc/lab-config
cd lab-config
sudo nixos-rebuild switch --flake .#nome-do-pc
```

## Como adicionar um novo computador
Crie uma pasta com o nome do novo PC em hosts com `mkdir hosts/nome-do-pc`.

Copie os arquivos de configurações existentes com `cp /etc/nixos/* hosts/nome-do-pc`, e use `git add -A` para serem trackeados. Edite esses arquivos se julgar nescessário.

Abra o `flake.nix`, adicione um item para o PC em `nixosConfigurations`.

Ative usando `sudo nixos-rebuild switch --flake .#nome-do-pc`.

## Como instalar o NixOS "do zero"
Talvez você queira reinstalar um dos PCs por qualquer motivo, ou instalar &
adicionar um PC novo. Consulte o [passos gerais o manual do NixOS se
nescessário](https://nixos.org/manual/nixos/stable/index.html#ch-installation).

- Baixe a última versão da ISO do NixOS, boote no computador.
- Particione os discos (pelo menos uma root e ESP)
- Monte a root em /mnt
- Monte a ESP em /mnt/boot
- Clone o repositório: `git clone https://gitlab.com/gelos-icmc/lab-config`
  (instale o git com `nix-env -iA nixos.git`, se nescessário)
- Faça bootstrap do nix com flakes usando `nix-shell`
- Caso o computador já esteja nesse repositório:
    - Certifique-se que a `hardware-configuration.nix` esteja usando labels ou
      com as UUIDs corretas, corrija se nescessário.
    - Instale com `sudo nixos-install --root /mnt --flake .#nome-do-pc`
- Caso o computador ainda não esteja nesse repositório:
    - Gere a configuração inicial usando `nixos-generate-config --root /mnt`
    - Siga os passos da [seção acima](#como-adicionar-um-novo-computador), mas
      ao invés de `nixos-rebuild` use: `sudo nixos-install --root /mnt --flake
      .#nome-do-pc`
