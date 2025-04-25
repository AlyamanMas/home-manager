{
  pkgs,
  config,
  ...
}:

let
  username = config.users.main-user;
in
{
  programs.fish.enable = true;
  users.users.${username}.shell = pkgs.fish;
}
