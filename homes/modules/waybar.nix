{
  config,
  pkgs,
  inputs,
  lib,
  ...
}@attrs:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      height = 32;
      output = "eDP-1";
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-right = [
        "cpu"
        "memory"
        "network"
        "battery"
        "clock"
      ];
    };
  };
}
