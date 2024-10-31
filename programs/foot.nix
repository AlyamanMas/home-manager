{
  enable = true;
  server.enable = true;
  settings = {
    main = {
      font = "JetBrainsMono Nerd Font:size=12";
      dpi-aware = "yes";
      initial-window-size-pixels = "770x500";
    };

    cursor = {
      blink = "yes";
    };

    colors = import ./foot/catppuccin-mocha.nix;

    csd = {
      preferred = "none";
    };

    scrollback = {
      lines = 2000;
    };

    key-bindings = {
      scrollback-up-page = "Control+Mod1+u";
      scrollback-up-line = "Control+Mod1+k";
      scrollback-down-page = "Control+Mod1+d";
      scrollback-down-line = "Control+Mod1+j";
      search-start = "Control+Mod1+slash";
      spawn-terminal = "Control+Mod1+n";
      show-urls-launch = "Control+Mod1+f";
    };
  };
}
