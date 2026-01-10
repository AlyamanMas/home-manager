{
  pkgs,
  config,
  lib,
  ...
}:
let
  toggle-brightness = pkgs.writeScriptBin "toggle-brightness.nu" /* nu */ ''
    #!/usr/bin/env nu

    let curr_brightness = brightnessctl get
    if $curr_brightness == "0" {
      brightnessctl set "100%"
    } else {
      brightnessctl set "0%"
    }
  '';
in
{
  imports = [
    ./dms.nix
    # ../modules/waybar.nix
  ];
  home.packages =
    with pkgs;
    [
      kdePackages.breeze
      brightnessctl
      toggle-brightness
    ]
    ++ lib.optionals (config.device.host == "ypc3") [
      (writeShellScriptBin "switch-refresh-rate-with-power-profiles.sh" (
        builtins.readFile ./switch-refresh-rate-with-power-profiles.sh
      ))
    ];
  xdg.configFile = {
    "niri/config.kdl" = {
      source = ./config/config.kdl;
      force = true;
    };
    "niri/environment.kdl" = {
      source = ./config/environment.kdl;
      force = true;
    };
    "niri/workspaces.kdl" = {
      source = ./config/workspaces.kdl;
      force = true;
    };
    "niri/input.kdl" = {
      source = ./config/input.kdl;
      force = true;
    };
    "niri/theme.kdl" = {
      source = ./config/theme.kdl;
      force = true;
    };
    "niri/keybinds.kdl" = {
      source = ./config/keybinds.kdl;
      force = true;
    };
    "niri/layout.kdl" = {
      source = ./config/layout.kdl;
      force = true;
    };
    "niri/outputs.kdl" =
      if config.device.host == "ypc3" then
        {
          source = ./config/outputs-ypc3.kdl;
          force = true;
        }
      else if config.host.device == "YPC2" then
        {
          source = ./config/outputs-ypc2.kdl;
          force = true;
        }
      else
        lib.warn "Device '${config.host.device}' is neither YPC2 nor ypc3. Using empty outputs.kdl" {
          text = "";
          force = true;
        };
  };
}
