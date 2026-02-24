{ config, ... }:

{
  virtualisation.libvirtd.enable = true;
  # if you use libvirtd on a desktop environment
  programs.virt-manager.enable = true; # can be used to manage non-local hosts as well
  users.users.${config.users.mainUser}.extraGroups = [ "libvirtd" ];

  # guest utilities
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
