{
  config,
  ...
}:
let
  username = config.users.mainUser;
  user = config.users.users.${username};
in
{
  services.lidarr = {
    enable = true;
    group = user.group;
    user = username;
    dataDir = "${user.home}/.config/Lidarr";
  };
}
