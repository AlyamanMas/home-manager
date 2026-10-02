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

  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = "${wallpaperPath}";
        }
      ];
    };
  };

  home.packages = [ pkgs.grimblast ];
}
