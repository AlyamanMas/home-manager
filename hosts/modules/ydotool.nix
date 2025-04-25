{
  config,
  ...
}:

let
  username = config.users.main-user;
in
{
  users.users.${username} = {
    extraGroups = [ "ydotool" ];
  };
  programs.ydotool.enable = true;
}
