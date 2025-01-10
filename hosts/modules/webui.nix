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
    ollama = {
      enable = true;
      # acceleration = "cuda";
      package = nixpkgs-unstable.ollama;
    };

    open-webui = {
      enable = true;
      # package = nixpkgs-unstable.open-webui;
      port = webuiPort;
    };
  };
}
