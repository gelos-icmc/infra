# Laboratório GELOS - Configurações

Configurações em Nix dos computadores do laboratório da linda sala do GELOS.

## (Re)instalar em dos PCs já listados
Para (re)instalar em um computador que já temos a config aqui, basta usar:

```bash
sudo nixos-rebuild switch --flake gitlab:gelos-icmc/lab-config#nome-do-pc
```

Ou clonar, entrar no diretório, e usar:
```bash
sudo nixos-rebuild switch --flake .#nome-do-pc
```

Sendo `nome-do-pc` um de:

- `emperor`: Servidor principal
- `galapagos`: Servidor secundário
- `macaroni`: All-in-one 1
- `rockhopper`: All-in-one 2 (no momento com pouca RAM)

## Como adicionar um novo computador

### Onde ainda não foi instalado NixOS
- Baixe [a última versão da ISO do NixOS](https://nixos.org/download.html#download-nixos), boote no computador.
- Faça o processo usual de instalação:
    - Particione os discos (pelo menos uma root e ESP)
    - Monte a root em `/mnt`
    - Monte a ESP em `/mnt/boot`
    - Gere a configuração inicial usando `nixos-generate-config --root /mnt`
- Clone esse repositório (instale o git com `nix-env -iA nixos.git`, se nescessário), e entre nele
- Adicione a config do computador
    - Crie uma pasta com o nome do novo PC em `hosts` com `mkdir hosts/nome-do-pc`
    - Copie seus arquivos gerados com `cp /mnt/etc/nixos/* hosts/nome-do-pc`, e use `git add -A` para serem trackeados
    - Edite esses arquivos se nescessário
    - Abra o `flake.nix`, adicione um item para o PC em `nixosConfigurations`
- Se nescessário, ative o nix com flakes usando `nix-shell`
- Pronto, basta instalar usando `sudo nixos-install --root /mnt --flake .#nome-do-pc`

### Caso já tenha sido instalado NixOS
Assim como acima, crie um diretório para o computador, adicione a configuração (`cp /etc/nixos hosts/nome-do-pc`), e adicione o host no `flake.nix`.

Ative usando `sudo nixos-rebuild switch --flake .#nome-do-pc`.

## Como adicionar um usuário
Clone o repositório, edite `users.nix`, e abra um MR.

Ative a configuração como de costume (`nixos-rebuild`).
