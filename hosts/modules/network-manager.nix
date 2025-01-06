{
  username,
  lib,
  ...
}:

{
  networking.networkmanager.enable = lib.mkDefault true;
  users.users.${username}.extraGroups = [ "networkmanager" ];
}
