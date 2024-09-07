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

    colors = import ./foot/paradise.nix;

    csd = {
      preferred = "none";
    };

    scrollback = {
      lines = 2000;
    };

    key-bindings = {
      scrollback-up-page = "Control+Mod1+Meta+u";
      scrollback-up-line = "Control+Mod1+Meta+k";
      scrollback-down-page = "Control+Mod1+Meta+d";
      scrollback-down-line = "Control+Mod1+Meta+j";
      search-start = "Control+Mod1+Meta+slash";
      spawn-terminal = "Control+Mod1+Meta+n";
      show-urls-launch = "Control+Mod1+Meta+f";
    };
  };
}
