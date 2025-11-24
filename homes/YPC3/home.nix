{
  ...
}:

{
  imports = [
    ../modules/env.nix
    ../modules/programs
    ../modules/hypr
    ../modules/waybar.nix
    ../modules/mako.nix
    ../modules/niri
    ../modules/device.nix
  ];

  device.host = "YPC3";

  home = {
    username = "alyaman";
    homeDirectory = "/home/alyaman";

    # NOTE: do not change
    stateVersion = "24.05";
  };
}
