{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  workspaceToKeyMap = [
    {
      ws = "1";
      key = "Q";
    }
    {
      ws = "2";
      key = "W";
    }
    {
      ws = "3";
      key = "E";
    }
    {
      ws = "4";
      key = "R";
    }
    {
      ws = "5";
      key = "A";
    }
    {
      ws = "6";
      key = "S";
    }
    {
      ws = "7";
      key = "D";
    }
    {
      ws = "8";
      key = "F";
    }
    {
      ws = "9";
      key = "1";
    }
    {
      ws = "10";
      key = "2";
    }
    {
      ws = "11";
      key = "3";
    }
  ];
in
{
  wayland.windowManager.hyprland = {
    enable = false;
    systemd.enable = false;
    settings = {
      monitor = [
        "eDP-1, disable"
      ];

      "$terminal" = "foot";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";

      "windowrulev2" = "suppressevent maximize, class:.*"; # You'll probably like this.

      bind =
        [
          "$mainMod, Return, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          # "$mainMod, V, togglefloating,"
          "$mainMod, V, exec, $menu"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, N, togglesplit, # dwindle"

          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          "$mainMod SHIFT, H, movewindow, l"
          "$mainMod SHIFT, L, movewindow, r"
          "$mainMod SHIFT, K, movewindow, u"
          "$mainMod SHIFT, J, movewindow, d"

          "$mainMod ALT, H, swapwindow, l"
          "$mainMod ALT, L, swapwindow, r"
          "$mainMod ALT, K, swapwindow, u"
          "$mainMod ALT, J, swapwindow, d"
        ]
        ++ (builtins.map (m: "$mainMod, " + m.key + ", workspace," + m.ws) workspaceToKeyMap)
        ++ (builtins.map (m: "$mainMod SHIFT, " + m.key + ", movetoworkspace," + m.ws) workspaceToKeyMap); # end bind

      # binde repeats keys
      binde = [
        "$mainMod, equal,       resizeactive, 10 0"
        "$mainMod, minus,       resizeactive, -10 0"
        "$mainMod SHIFT, equal, resizeactive, 0 -10"
        "$mainMod SHIFT, minus, resizeactive, 0 10"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ]; # end bindm

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 5;
        gaps_out = 12;

        border_size = 3;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        # allow_tearing = false;

        layout = "dwindle";
      }; # end general

      debug = {
        disable_logs = false;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        dim_inactive = true;
        dim_strength = 0.3;

        # drop_shadow = true;
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          # enabled = false;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      }; # end decoration

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ]; # end animation
      }; # end animations

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section
        preserve_split = true; # You probably want this
      }; # end dwindle

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      }; # end master

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
        focus_on_activate = true;
      }; # end misc

      # opengl = {
      #   # Makes things much smoother if false but lots of graphical bugs :(
      #   nvidia_anti_flicker = true;
      # };

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        repeat_delay = 300;
        repeat_rate = 25;

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = false;
        };
      }; # end input

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures = {
        workspace_swipe = false;
      }; # end gestures

      # env = [
      #   "AQ_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
      # ];
    }; # end settings
  }; # end hyprland
}
