{
  config,
  ...
}:

let
  usbipPackage = config.boot.kernelPackages.usbip;
in
{
  boot = {
    extraModulePackages = [ usbipPackage ];
  };

  environment.systemPackages = [ usbipPackage ];
}
