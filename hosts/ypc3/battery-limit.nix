{
  imports = [ ./battery.nix ];
  hardware.asus.battery = {
    chargeUpto = 90; # Maximum level of charge for your battery, as a percentage.
    enableChargeUptoScript = true; # Whether to add charge-upto to environment.systemPackages. `charge-upto 100` temporarily sets the charge limit to 100%, useful if you're going to need the extra battery on a longer journey.
  };
}
