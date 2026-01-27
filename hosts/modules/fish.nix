{
  pkgs,
  config,
  ...
}:

let
  username = config.users.mainUser;
in
{
  programs.fish.enable = true;
  users.users.${username}.shell = pkgs.fish;
}
