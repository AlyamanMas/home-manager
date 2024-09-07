{
  config,
  pkgs,
  inputs,
  ...
}@attrs:

{
  home.packages = with pkgs; [
    wget
    keepassxc
    nix-prefetch-scripts
    dconf-editor
    gnome-tweaks
    nixfmt-rfc-style
    ripgrep
    libreoffice-qt
    wl-clipboard
    papers
    inputs.nixvim.packages.x86_64-linux.default
  ];

  programs.git = {
    enable = true;
    userEmail = "alyaman.maasarani@gmail.com";
    userName = "Alyaman Massarani";
    extraConfig = {
      safe = {
        directory = "/etc/nixos";
      };
    };
    diff-so-fancy = {
      enable = true;
    };
  };

  programs.gh = {
    enable = true;
  };

  programs.foot = import ./programs/foot.nix;

  services.syncthing = {
    enable = true;
  };

  programs.tealdeer = {
    enable = true;
    settings.auto_update = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.chromium = {
    enable = true;
  };

  programs.mpv = {
    enable = true;
  };

  programs.fish = import ./programs/fish.nix attrs;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
