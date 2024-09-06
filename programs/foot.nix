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

    # TODO: add keybindings
  };
}
