{
  pkgs,
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

      wallpaper = , ${wallpaperPath}

      ipc = off
    '';
  };

  home.packages = [ pkgs.grimblast ];
}
