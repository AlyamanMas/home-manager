{
  lib,
  config,
  ...
}:

let
  username = config.users.main-user;
in
{
  networking.networkmanager.enable = lib.mkDefault true;
  users.users.${username}.extraGroups = [ "networkmanager" ];
}
