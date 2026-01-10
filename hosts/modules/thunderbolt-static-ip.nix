/**
  This exists for the sake of establishing a direct connection between YPC2
  and YPC3 via thunderbolt with predictable IP addresses and host names.
*/
{ config, ... }:

let
  isYPC3 = config.networking.hostName == "ypc3";
  myIp = if isYPC3 then "10.0.39.1" else "10.0.39.2";
  myAddress = "${myIp}/30";
in
{
  # Prevent NetworkManager from managing this device.
  # If you don't do this, NetworkManager will fight systemd-networkd
  # and try to assign an APIPA address.
  networking.networkmanager.unmanaged = [ "thunderbolt0" ];

  # Enable systemd-networkd (it can run alongside NetworkManager)
  systemd.network = {
    enable = true;

    networks."10-thunderbolt" = {
      # This tells systemd: "Watch for an interface named thunderbolt0"
      matchConfig.Name = "thunderbolt0";

      # Apply these settings whenever the interface appears
      networkConfig = {
        Address = myAddress;
        # Optional: Keep the link up even if carrier is lost momentarily
        KeepConfiguration = "yes";
      };

      # Crucial: Don't let the boot process hang waiting for this cable
      linkConfig.RequiredForOnline = "no";
    };
  };

  networking.hosts = {
    "10.0.39.1" = [ "ypc3.local" ];
    "10.0.39.2" = [ "ypc2.local" ];
  };
}
