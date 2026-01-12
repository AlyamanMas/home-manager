{
  pkgs,
  ...
}:

{
  imports = [
    ../modules/env.nix
    ../modules/programs.nix
    ../modules/hypr
    ../modules/mako.nix
    ../modules/niri
    ../modules/device.nix
    ../modules/flatpak.nix
    ../modules/fish.nix
    ../modules/nushell.nix
    ../modules/foot
    ../modules/git.nix
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
