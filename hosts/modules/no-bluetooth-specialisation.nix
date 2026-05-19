{ lib, ... }:

{
  specialisation = {
    no-bluetooth.configuration = {
      hardware.bluetooth.enable = lib.mkForce false;
      services.blueman.enable = lib.mkForce false;
      boot.blacklistedKernelModules = [
        "btusb"
        "bluetooth"
      ];
    };
  };
}
