{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "gelos" ];
  };
}
