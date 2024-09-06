{
  config,
  pkgs,
  inputs,
  ...
}:

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

  programs.fish = {
    enable = true;
    plugins = [
      {
        # Allows to source bash/shell scripts
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "79b62958ecf4e87334f24d6743e5766475bcf4d0";
          sha256 = "0dy53vzzpclw811gxv1kazb8rm7r9dyx56f5ahwd1g38x0pympyx";
        };
      }
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
    shellInit = ''
      set -gx EDITOR nvim
    '';
  };
}
