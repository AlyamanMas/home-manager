{
  config,
  lib,
  pkgs,
  nixpkgs-unstable,
  ...
}@args:

{
  imports = [
    ./hardware-configuration.nix
    ./reverse-proxy.nix

    ../modules/main-user.nix
    ../modules/fish.nix
    ../modules/nix.nix
    ../modules/vaultwarden.nix
    ../modules/tika.nix
    # ../modules/docker.nix
    ../modules/podman.nix
    # ../modules/webui-docker.nix
    (import ../modules/webui.nix (args // { webuiPort = 1115; }))
    ../modules/searxng.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  time.timeZone = "Europe/Berlin";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking = {
    hostName = "YVPSH";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
    hosts = {
      "127.0.0.1" = [ "tlsymposium.com" ];
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "24.05"; # Did you read the comment?
}
