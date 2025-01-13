{
  username,
  ...
}:

{
  users.users.${username} = {
    extraGroups = [ "ydotool" ];
  };
  programs.ydotool.enable = true;
}
