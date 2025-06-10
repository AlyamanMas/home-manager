# TODO: add tray
# TODO: add bluetooth
# TODO (maybe?): add media
# TODO (maybe?): add netowrk traffic module
# TODO (maybe?): switch all right icons to automatically opening drawers
# TODO: prayer time module
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}@attrs:

let
  palette = (import ../../common/themes/catppuccin.nix).currentPalette;
  yvpsh-wg-get-state = pkgs.writeScript "yvpsh-wg-get-state.sh" ''
    #!/usr/bin/env sh

    not_connected=`nmcli connection show --active | grep yvpsh-wg | wc -l`
    if [ "$not_connected" -gt 0 ]; then
      echo vpn_key
    else
      echo vpn_key_off
    fi
  '';
  iconNameToMaterialSymbolsSpan =
    icon: ''<span font-family="Material Symbols Outlined 28pt" font-size="16pt">'' + icon + "</span>";
  iconNamesListToMaterialSymbolsSpans = list: builtins.map iconNameToMaterialSymbolsSpan list;
in
{
  programs.waybar = {
    enable = true;
    style = ''
      * {
        color: ${palette.text}
      }

      .module {
        font-family: "Roboto";
        padding: 0 0.3rem;
      }

      .modules-right {
        margin-right: 1rem;
      }

      .modules-left {
        margin-left: 1rem;
      }

      window {
        background-color: ${palette.mantle};
      }

      #workspaces {
        padding: 0rem;
      }

      #workspaces button {
        font-family: "Material Symbols Outlined 28pt";
        font-size: 16pt;
        padding: 0 0.3rem;
      }

      #workspaces button:hover {
        border-color: ${palette.mantle};
        background-image: none;
      }

      #workspaces button.active label {
        color: ${palette.blue};
      }
    '';
    settings.mainBar = {
      height = 32;
      output = "eDP-1";
      layer = "top";
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-right = [
        "cpu"
        "memory"
        "custom/wg"
        "network"
        "clock"
      ];

      network = {
        format = "{icon}";
        format-alt = "{icon}  <span rise=\"6pt\">{essid}</span>";
        format-disconnected = iconNameToMaterialSymbolsSpan "signal_wifi_off";
        format-icons = iconNamesListToMaterialSymbolsSpans [
          "network_wifi_1_bar"
          "network_wifi_2_bar"
          "network_wifi_3_bar"
          "signal_wifi_4_bar"
        ];
        tooltip-format = ''
          <tt>Network: {essid}
          Down:    {bandwidthDownBytes}
          Up:      {bandwidthUpBytes}</tt> '';
        on-click-right = "xdg-terminal nmtui";
        interval = 1;
      };

      "custom/wg" = {
        exec = yvpsh-wg-get-state;
        format = iconNameToMaterialSymbolsSpan "{}";
        tooltip = false;
        interval = 2;
      };

      cpu = {
        format = "{icon}";
        format-icons =
          builtins.map
            (colorHex: ''<span color="${colorHex}">'' + (iconNameToMaterialSymbolsSpan "memory") + "</span>")
            [
              palette.text
              palette.yellow
              palette.peach
              palette.red
            ];
      };

      memory = {
        format = "{icon}";
        format-icons =
          builtins.map
            (
              colorHex: ''<span color="${colorHex}">'' + (iconNameToMaterialSymbolsSpan "memory_alt") + "</span>"
            )
            [
              palette.text
              palette.yellow
              palette.peach
              palette.red
            ];
      };

      clock = {
        format = "<b><big>{:%H:%M}</big></b>";
        format-alt = "<b><big>{:%A, %B %d, %Y (%R)}</big></b>";
        tooltip = false;
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "globe_asia";
          "2" = "terminal";
          "3" = "code";
          "4" = "data_object";
          "5" = "calendar_today";
          "6" = "image";
          "7" = "folder";
          "8" = "book";
          "9" = "globe_uk";
          "10" = "computer";
          "11" = "dictionary";
        };
      };
    }; # end settings.mainBar
  };
}
