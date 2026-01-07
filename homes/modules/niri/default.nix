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
    ++ lib.optionals (config.device.host == "YPC3") [
      (writeShellScriptBin "switch-refresh-rate-with-power-profiles.sh" (
        builtins.readFile ./switch-refresh-rate-with-power-profiles.sh
      ))
    ];
  xdg.configFile = {
    "niri/config.kdl" = {
      source = ./config.kdl;
      force = true;
    };
    "niri/environment.kdl" = {
      source = ./environment.kdl;
      force = true;
    };
    "niri/outputs.kdl" =
      if config.device.host == "YPC3" then
        {
          source = ./outputs-ypc3.kdl;
          force = true;
        }
      else if config.host.device == "YPC2" then
        {
          source = ./outputs-ypc2.kdl;
          force = true;
        }
      else
        lib.warn "Device '${config.host.device}' is neither YPC2 nor YPC3. Using empty outputs.kdl" {
          text = "";
          force = true;
        };
  };
}
