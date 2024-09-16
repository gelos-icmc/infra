{
  users.users.gelosentity = {
    isNormalUser = true;
    description = "GELOS-Entity"; # infra (nixos config) cloned on this user's home
    extraGroups = ["networkmanager" "wheel"];
    initialPassword = "gelos2024";
    packages = [
    ];
  };
}
