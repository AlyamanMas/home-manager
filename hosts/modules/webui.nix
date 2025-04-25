{
  config,
  lib,
  pkgs,
  nixpkgs-unstable,
  webuiPort ? 11111,
  ...
}:

{
  services = {
    open-webui = {
      enable = true;
      package = nixpkgs-unstable.open-webui;
      port = webuiPort;
    };
  };
}
