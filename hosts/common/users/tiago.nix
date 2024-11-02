{
  users.users.tiago = {
    isNormalUser = true;
    description = "GELOS-Tiago"; # infra (nixos config) cloned on this user's home
    extraGroups = ["networkmanager" "wheel"];
    initialPassword = "gelos2024";
    packages = [];
  };
}
