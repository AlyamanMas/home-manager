{
  config,
  lib,
  pkgs,
  ...
}:

{
  services = {
    xserver.enable = true;
    # services.displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    # Needed to run in Wayland mode according to wiki; haven't tested without
    # displayManager.defaultSession = "plasma";
    # displayManager.sddm.enable = lib.mkForce true;
    # displayManager.execCmd = lib.mkForce "exec /run/current-system/sw/bin/sddm";
  };
  # Needed for compatibility with GNOME
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse.out}/libexec/seahorse/ssh-askpass";
}
