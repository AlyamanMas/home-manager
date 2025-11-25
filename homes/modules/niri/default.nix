{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    kdePackages.breeze
  ];
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };
}
