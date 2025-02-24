{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages."x86_64-linux".hyprland;
  };

  services.displayManager.defaultSession = "hyprland";

  environment.systemPackages = with pkgs; [
    hyprpaper
  ];
}
