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
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };
}
