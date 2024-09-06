{ config, pkgs, ... }:

{
  imports = [ ./nixvim/default.nix ];

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

  programs.foot = {
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

      colors = {
        # Catppuccin mocha theme
        foreground = "cdd6f4";
        background = "1e1e2e";

        regular0 = "45475a";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "f5c2e7";
        regular6 = "94e2d5";
        regular7 = "bac2de";

        bright0 = "585b70";
        bright1 = "f38ba8";
        bright2 = "a6e3a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "f5c2e7";
        bright6 = "94e2d5";
        bright7 = "a6adc8";

        selection-foreground = "cdd6f4";
        selection-background = "414356";

        search-box-no-match = "11111b f38ba8";
        search-box-match = "cdd6f4 313244";

        jump-labels = "11111b fab387";
        urls = "89b4fa";
      };

      csd = {
        preferred = "none";
      };

      # TODO: add keybindings
    };
  };

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
