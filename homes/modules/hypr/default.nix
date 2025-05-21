{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  wallpaperPath = ../../res/wallpapers/cat_pacman.png;
in
{
  xdg.configFile."hypr" = {
    recursive = true;
    source = ./.;
  };

  xdg.configFile."hypr/hyprpaper.conf" = {
    text = ''
      preload = ${wallpaperPath}

      wallpaper = eDP-1, ${wallpaperPath}
      wallpaper = DP-1, ${wallpaperPath}

      ipc = off
    '';
  };
}
