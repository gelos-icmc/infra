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

- Antes de tudo, crie uma nova branch com o nome no padrão "user/{seu-user}"! (ex: `git checkout -b user/fulano`)
- Coloque seu usuário no arquivo [users.nix](https://gitlab.com/gelos-icmc/lab-config/-/blob/main/users.nix)
- Siga o modelo dos usuários anteriores, se atentando à sintaxe do Nix. Basicamente serão as mesmas configurações, 
mudando apenas a senha (*initialHashedPassword*), o *sheel* (caso queira usar um outro que não o *bash*) e sua chave ssh (caso queira acessar remotamente os servers).

### Criar senha:

A senha deve estar no padrão unix... 

### Criar chave ssh:
A chave ssh é necessária caso você queira acessar os servidores por... ssh! Se for o caso, siga os passos:

- `ssh-keygen -t [rsa|ed25519] # use ed25519 ou rsa`
- COloque o caminho do arquivo onde sua chave privada/publica será salva [caminho pra onde sua chave será salva]`
- Depois escolha uma **boa** senha, que você não use em outros lugares, mais de 8 caracteres, maiúscula, minúscula, números e caracteres especiais.
- Repita a senha.

Sua chave privada é seu santo grau e deve ser armazenada num lugar seguro.

Feito os passos, no campo *openssh.authorizedKeys.keys* atribua sua chave pública, que estará num arquivo *.pub* de mesmo nome que o da chave privada.
 
 


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
