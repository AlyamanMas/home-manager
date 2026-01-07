{
  pkgs,
  pkgsUnstable,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./hardware-accelerated-decoding.nix
    # ./local-domains.nix
    # ./autossh-tunneling.nix

    ../modules/efi-systemd-boot.nix
    ../modules/kde.nix
    ../modules/gnome.nix
    # ../modules/cachix
    # ../modules/webui.nix
    ../modules/hyprland.nix
    ../modules/fonts.nix
    ../modules/nix.nix
    ../modules/sound.nix
    ../modules/local-locale.nix
    # ../modules/docker.nix
    ../modules/fish.nix
    ../modules/network-manager.nix
    ../modules/main-user.nix
    # ../modules/jupyter-docker.nix
    ../modules/xbox.nix
    # ../modules/ollama.nix
    # ../modules/waydroid.nix
    ../modules/niri.nix
    # ../modules/thunderbolt-static-ip.nix
    ../modules/avahi.nix
    ../modules/logind.nix
    ../modules/man.nix
  ];

  services.displayManager.defaultSession = "niri";

  networking = {
    hostName = "YPC3-NIXOS";
    firewall.enable = false;
  };

  environment.systemPackages = with pkgs; [
    neovim
    killall
    # cachix
    nethogs
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgsUnstable; [
      proton-ge-bin
    ];
  };

  services = {
    printing.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    blueman.enable = true;
  };

  powerManagement.enable = true;

  specialisation = {
    newerKernel.configuration = {
      boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_17;
    };
  };

  # This value determines the NixOS release from which the
  # default settings for stateful data, like file locations and
  # database versions on your system were taken. It‘s perfectly
  # fine and recommended to leave this value at the release
  # version of the first install of this system. Before
  # changing this value read the documentation for this option
  # (e.g. man configuration.nix or on
  # https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
