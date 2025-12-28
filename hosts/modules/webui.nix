{
  lib,
  pkgsUnstable,
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
}
