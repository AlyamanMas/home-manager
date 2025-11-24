# TODO: add bluetooth
# TODO (maybe?): add media
# TODO (maybe?): switch all right icons to automatically opening drawers
# TODO: prayer time module
# TODO: add notification do not disturb mode toggler/notification manager
# TODO: add clipboard manager
# TODO: fmt all numbers
{
  pkgs,
  ...
}:

let
  palette = (import ../../common/themes/catppuccin.nix).currentPalette;
  yvpsh-wg-get-state = pkgs.writeScript "yvpsh-wg-get-state.sh" /* sh */ ''
    #!/usr/bin/env sh

    [ `nmcli connection show --active | grep yvpsh-wg | wc -l` -gt 0 ] && echo vpn_key || echo vpn_key_off
  '';
  colorSpan = color: text: ''<span color="${color}">${text}</span>'';
  iconNameToMaterialSymbolsSpan =
    icon: ''<span font-family="Material Symbols Outlined" font-size="16pt">'' + icon + "</span>";
  iconNamesListToMaterialSymbolsSpans = list: builtins.map iconNameToMaterialSymbolsSpan list;
  # TODO: this looks weird on YPC3
  spanRaise = text: "<span rise=\"6pt\">" + text + "</span>";
  spanRaiseBold = text: "<b>" + spanRaise text + "</b>";
in
{
  programs.waybar = {
    enable = true;
    style = /* css */ ''
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
      position = "bottom";
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-right = [
        "tray"
        "niri/language"
        "network#bandwidth"
        "disk"
        "cpu"
        "memory"
        "wireplumber"
        "custom/wg"
        "network"
        "battery"
        "clock"
      ];

      network = {
        format = "{icon} " + spanRaiseBold "{essid}";
        format-disconnected = iconNameToMaterialSymbolsSpan "signal_wifi_off";
        format-ethernet = iconNameToMaterialSymbolsSpan "lan";
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

      "network#bandwidth" = {
        format = iconNameToMaterialSymbolsSpan "swap_vert" + spanRaiseBold " {bandwidthTotalBytes}";
        format-disconnected = iconNameToMaterialSymbolsSpan "mobiledata_off";
        tooltip = false;
        interval = 1;
      };

      "custom/wg" = {
        exec = yvpsh-wg-get-state;
        format = iconNameToMaterialSymbolsSpan "{}";
        tooltip = false;
        interval = 2;
      };

      disk = {
        format = iconNameToMaterialSymbolsSpan "storage" + spanRaiseBold " {specific_free:0.1f}GiB";
        unit = "GiB";
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

      wireplumber = {
        format = "{icon} " + spanRaiseBold "{volume}%";
        format-muted = iconNameToMaterialSymbolsSpan "volume_off";
        format-icons = iconNamesListToMaterialSymbolsSpans [
          "volume_down"
          "volume_up"
        ];
      };

      battery = {
        # TODO: Make battery red when low
        format = "{icon}" + spanRaiseBold "{capacity}%";
        # TODO: have different charging icons using format-<status>-<state> with multiple states
        format-charging = colorSpan palette.yellow ("{icon}" + spanRaiseBold "{capacity}%");
        format-muted = iconNameToMaterialSymbolsSpan "volume_off";
        format-icons = iconNamesListToMaterialSymbolsSpans [
          "battery_0_bar"
          "battery_1_bar"
          "battery_2_bar"
          "battery_3_bar"
          "battery_4_bar"
          "battery_5_bar"
          "battery_6_bar"
          "battery_full"
        ];
        interval = "10";
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
        all-outputs = true;
      };

      "niri/language" = {
        "format" = iconNameToMaterialSymbolsSpan "language_japanese_kana" + spanRaiseBold " {long}";
        "format-us" = "English";
        "format-ara" = "Arabic";
      };
    }; # end settings.mainBar
  };
}
