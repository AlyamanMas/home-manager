{
  config,
  lib,
  pkgs,
  nixpkgs-unstable,
  ...
}:

{
  services = {
    open-webui = {
      enable = true;
      package = nixpkgs-unstable.open-webui;
      port = lib.mkDefault 1115;
    };
  };
}
