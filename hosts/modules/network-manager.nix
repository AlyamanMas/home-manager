{
  lib,
  config,
  ...
}:

let
  username = config.users.mainUser;
in
{
  networking.networkmanager.enable = lib.mkDefault true;
  users.users.${username}.extraGroups = [ "networkmanager" ];
}
