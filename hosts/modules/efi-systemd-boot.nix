{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      # efiSysMountPoint = "/boot";
    };
    systemd-boot = {
      enable = true;
    };
  };
}
