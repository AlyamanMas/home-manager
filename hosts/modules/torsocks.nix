_:

{
  services.tor = {
    enable = true;

    # Enable Torsocks for transparent proxying of applications through Tor
    torsocks.enable = true;
    torsocks.allowInbound = true;

    # Enable the Tor client
    client = {
      enable = true;
    };
  };
}
