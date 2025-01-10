{
  pkgs,
  lib,
  config,
  ...
}:

{
  services.tor = {
    enable = true;

    # Enable Torsocks for transparent proxying of applications through Tor
    torsocks.enable = true;

    # Enable the Tor client
    client = {
      enable = true;
    };
  };
}
