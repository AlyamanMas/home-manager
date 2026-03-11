{
  config,
  ...
}:

let
  cfg = config.services.syncthing;
in
{
  imports = [
    ./reverse-proxy.nix
  ];

  services.syncthing = {
    enable = true;
    guiAddress = "/run/syncthing/syncthing.sock";
  };
  # automatically creates a runtime directory at `/run/syncthing` so that `guiAddress` can create its socket in it
  systemd.services.syncthing.serviceConfig = {
    RuntimeDirectory = "syncthing";
    RuntimeDirectoryMode = "0770";
    # UMask 0007 ensures new files (including socket) get g+w. this is needed so nginx can communicate with syncthing.
    # 0777 - 0007 = 0770 for directories, 0666 - 0007 = 0660 for files
    UMask = "0007";
    StateDirectory = "syncthing";
    StateDirectoryMode = "0770";
  };

  # so the main user can access the synced files
  users.users.${config.users.mainUser}.extraGroups = [
    cfg.group
  ];
  # add so syncthing can read files added by users to the datadir
  users.users.syncthing.extraGroups = [
    "users"
  ];
  # add so nginx can access the unix socket of the gui
  users.users.nginx.extraGroups = [ cfg.group ];

  custom.reverseProxy.mappings = {
    syncthing = "unix:${cfg.guiAddress}";
  };
}
