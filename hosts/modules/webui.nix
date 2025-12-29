{
  lib,
  pkgsUnstable,
  config,
  ...
}:

{
  services = {
    open-webui = {
      enable = true;
      package = pkgsUnstable.open-webui;
      port = lib.mkDefault 1115;
    };
  };

  custom.reverseProxy.mappings.webui = config.services.open-webui.port;
}
