# Laboratório GELOS - Configurações

Configurações em Nix dos computadores do laboratório da linda sala do GELOS.

## Mandamentos:

1. Não pusharás na main
2. Não usarás a conta do amiguinho para dar um push na main
3. Não deixarás Setembro utilizar sua conta sem supervisão

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

## Como adicionar um novo usuário

Hoje gerimos os usuários pelo repositório, configurando através do NixOS e
gerindo a senha com o `sops`. Isso é relativamente temporário, pois teremos
autenticação centralizada nos computadores em breve. Se esses passos abaixo
forem muito complicados, avise o Gabriel que ele faz pra você.

### Preliminares

Antes de mais nada, clone o repositório e crie uma nova branch. Você também (se
estiver fazendo o setup mais simples) pode optar por usar o editor online do
gitlab. No final disso, vamos abrir um MR para que suas mudanças sejam
aceitas.

Para começar, crie uma pasta com seu usuário em `users`, e liste ela em
`users/default.nix`.

### Gerando hash da sua senha

Use o comando `mkpasswd -m sha-512`, e digite sua senha desejada. Será exibida
ela em versão hasheada.

### SSH e/ou encriptação da senha (OPCIONAL)

Para poder adicionar sua senha de maneira segura no repositório, bem como
acessar remotamente os servidores, você precisa ter uma chave SSH ou PGP.

Caso você não tenha nenhuma das duas, vamos te ajudar a criar uma SSH, por ser
mais simples de começar.

- Use `ssh-keygen -t ed25519` (você também pode usar rsa, se preferir).
- Será perguntado onde salvar a chave, pode só apertar enter se não quiser
  trocar o local.
- Digite uma **boa** senha, que você não reuse, com boa entropia (mais de 8
  caracteres, letras, numeros, símbolos), e aperte enter. Depois repita ela
  para confirmar.
- Pronto, cuide bem dela!

### Criando seu usuário

<details>
<summary>Versão mais simples com senha hardcodada</summary>
Aora dentro da sua pasta de usuário, crie um arquivo `default.nix`. Siga esse
exemplo (troque `seu-nome` pelo seu usuário, claro):
```nix
{ pkgs, ... }:
{
  users.users.seu-nome = {
    isNormalUser = true;
    # Pode trocar sua shell, se não for usar o bash
    # shell = pkgs.fish;
    extraGroups = [
      # Lembre de colocar se for usar um dos desktops
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      # Coloque sua chave pública SSH aqui
      "ssh-rsa ......"
    ];
    initialHashedPassword = "coloque sua senha haseada aqui";
  };
}
```
</details>

<details>
<summary>Versão com senha encriptada usando SOPS</summary>

Caso você use chave SSH, gere a versão age com `ssh-to-age <
~/.ssh/id_ed25519.pub` (trocando o caminho se nescessário).

Caso use PGP, pegue o fingerprint usando `gpg -K`

Abra o arquivo .sops.yaml:
- Adicione sua chave em dentro da seção `admins` em `keys` Deve ficar assim:
```yaml
keys:
  - &servers
  # ...chaves de servidores...
  - &admins
    age:
    # ...outras pessoas que usam age...
    - &admin_seu_nome sua chave publica age aqui # caso você use age
    pgp:
    # ...outras pessoas que usam pgp...
    - &admin_seu_nome sua fingerprint PGP aqui # caso você use pgp
```
- Adicione uma `creation_rule`, pode copiar a de alguém e trocar o usuário pelo
  seu. Deve ficar algo assim:
```yaml
creation_rules:
  # ...outras regras das pessoas aqui...
  - path_regex: users/seu-nome/pass.yaml
    key_groups:
    - age: # Troque por pgp ou age
      - *admin_seu_nome
      <<: *servers
```
- Crie e edite o seu arquivo de segredos com `sops users/seu-nome/pass.yaml`. Deve ficar assim:
```yaml
seu-nome-password: "hash da sua senha aqui"
```

Aora dentro da sua pasta de usuário, crie um arquivo `default.nix`. Siga esse
exemplo (troque `seu-nome` pelo seu usuário, claro):
```nix
{ pkgs, config, ... }:
{
  sops.secrets.seu-nome-password = {
    sopsFile = ./pass.yaml;
    neededForUsers = true;
  };

  users.users.seu-nome = {
    isNormalUser = true;
    # Pode trocar sua shell, se não for usar o bash
    # shell = pkgs.fish;
    extraGroups = [
      # Lembre de colocar se for usar um dos desktops
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      # Coloque sua chave pública SSH aqui
      "ssh-rsa ......"
    ];
    passwordFile = config.sops.secrets.seu-nome-password.path;
  };
}
```
</details>

Prontinho! Basta abrir seu MR e, quando aprovado, seu usuário será
automaticamente enviado aos computadores.

Nota: Hoje o deployment automático acontece nos servidores, então os admins tem
que fazer deployment manual nos desktops. Futuramente será 100% automático.

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
- Abra a shell com pacotes nescessários usando `nix --extra-experimental-features "nix-command flakes" develop`
- Caso o computador já esteja nesse repositório:
    - Certifique-se que a `hardware-configuration.nix` tenha as partições
      listadas usando labels ou com as UUIDs corretas, corrija se nescessário.
    - Instale com `sudo nixos-install --root /mnt --flake .#nome-do-pc`
- Caso o computador ainda não esteja nesse repositório:
    - Gere a configuração inicial usando `nixos-generate-config --root /mnt`
    - Como na seção [como adicionar um novo computador](#como-adicionar-um-novo-computador):
        - Crie um diretório `hosts/nome-do-pc`
        - Copie as configs geradas usando `cp /mnt/etc/nixos/* hosts/nome-do-pc`
        - Adicione o item para o PC em `flake.nix`
        - Instale com `sudo nixos-install --root /mnt --flake .#nome-do-pc`.
