{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.gitea = {
    enable = true;
    settings.server.ROOT_URL = "https://gitea.tlsymposium.com";
    settings.server.DOMAIN = "gitea.tlsymposium.com";
  };
}
