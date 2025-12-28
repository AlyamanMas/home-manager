_: {
  # Enable Avahi for NDI discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true; # crucial for resolving .local names
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
