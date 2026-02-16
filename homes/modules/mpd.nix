{
  config,
  ...
}:

{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music/library";
    network = {
      startWhenNeeded = true;
    };
  };
}
