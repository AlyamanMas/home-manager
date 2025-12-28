{
  config,
  ...
}:

{
  hardware.xpadneo.enable = true;
  hardware.xone.enable = true;
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.xpadneo ];
  };
}
