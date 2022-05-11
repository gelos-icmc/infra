{
  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.gelos.club";
    interfaceConfig = {
      APP_NAME = "Meet do GELOS";
      SHOW_JITSI_WATERMARK = false;
      DISPLAY_WELCOME_FOOTER = false;
    };
    nginx.enable = true;
    jibri.enable = true;
  };

  networking.firewall = {
    allowedUDPPorts = [ 10000 ];
    allowedTCPPorts = [ 4433 5222 ];
  };
}
