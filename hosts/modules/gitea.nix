{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.gitea = {
    enable = true;
    settings = {
      server = {
        ROOT_URL = "https://gitea.tlsymposium.com";
        DOMAIN = "gitea.tlsymposium.com";
      };
      service.DISABLE_REGISTRATION = true;
    };
  };
}
