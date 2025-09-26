{
  pkgs,
  lib,
  ...
}:

{
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = lib.mkDefault true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
      # + ''
      #   [org.gnome.desktop.wm.keybindings]
      #   switch-to-workspace-5=["<Super>a"];
      #   switch-to-workspace-6=["<Super>s"];
      #   switch-to-workspace-7=["<Super>d"];
      #   switch-to-workspace-8=["<Super>f"];
      #   switch-to-workspace-9=["<Super>1"];
      #   switch-to-workspace-10=["<Super>2"];
      #   switch-to-workspace-11=["<Super>3"];
      #   move-to-workspace-5=["<Shift><Super>a"];
      #   move-to-workspace-6=["<Shift><Super>s"];
      #   move-to-workspace-7=["<Shift><Super>d"];
      #   move-to-workspace-8=["<Shift><Super>f"];
      #   move-to-workspace-9=["<Shift><Super>1"];
      #   move-to-workspace-10=["<Shift><Super>2"];
      #   move-to-workspace-11=["<Shift><Super>3"];
      # '';
    };
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.unite
    gnomeExtensions.impatience
    gnomeExtensions.paperwm
    gnomeExtensions.panel-corners
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-indicator
  ];
}
