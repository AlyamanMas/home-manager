{
  pkgs,
  ...
}:

{
  imports = [
    ../modules/env.nix
    ../modules/programs
    ../modules/hypr
    ../modules/mako.nix
    ../modules/niri
    ../modules/device.nix
  ];

  device.host = "ypc3";

  home = {
    username = "alyaman";
    homeDirectory = "/home/alyaman";

    packages = with pkgs; [
      sunshine
    ];

    # NOTE: do not change
    stateVersion = "24.05";
  };
}
