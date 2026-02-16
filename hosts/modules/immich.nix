{
  config,
  ...
}:

{
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    settings.server.externalDomain = "https://immich.${config.secrets.mainDomain}";
  };

  custom.reverseProxy.mappings.immich = config.services.immich.port;
}
