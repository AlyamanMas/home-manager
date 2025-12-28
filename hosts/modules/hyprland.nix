{
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages."x86_64-linux".hyprland;
  };

  environment.systemPackages = with pkgs; [
    hyprpaper
  ];
}
