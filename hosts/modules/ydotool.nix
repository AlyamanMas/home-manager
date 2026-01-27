{
  config,
  ...
}:

let
  username = config.users.mainUser;
in
{
  users.users.${username} = {
    extraGroups = [ "ydotool" ];
  };
  programs.ydotool.enable = true;
}
