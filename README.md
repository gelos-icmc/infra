# Laboratório GELOS - Configurações

Configurações em Nix dos computadores do laboratório da linda sala do GELOS.

Para instalar em um computador novo, basta usar:

```bash
sudo nixos-rebuild switch --flake gitlab:gelos-icmc/lab-config#nome-do-pc
```

Sendo `nome-do-pc` um de:

- `emperor`: Servidor principal
- `galapagos`: Servidor secundário
- `macaroni`: All-in-one 1
- `rockhopper`: All-in-one 2 (no momento com pouca RAM)

Não há configurações do home-manager aqui, é esperado que cada usuário use um
repo próprio pra isso.
