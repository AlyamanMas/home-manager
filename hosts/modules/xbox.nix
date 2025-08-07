{
  pkgs,
  config,
  ...
}:

{
  hardware.xpadneo.enable = true;
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.xpadneo ];
  };
}
