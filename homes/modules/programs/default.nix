{
  config,
  pkgs,
  inputs,
  lib,
  ...
}@attrs:
let
  nwgShellPrograms = with pkgs; [
    nwg-look
    nwg-panel
    nwg-displays
    nwg-launchers
  ];
in
{
  home.packages =
    with pkgs;
    [
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
      gnome-music
      zotero_7
      jetbrains.pycharm-professional
      yt-dlp
      ffmpeg
      gnome-solanum
      pomodoro-gtk
      kitty
      wofi
      fd
      btop
      pavucontrol
      inputs.hyprpanel.outputs.packages.x86_64-linux.default
      inputs.zen-browser.outputs.packages.x86_64-linux.default
      (inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
        inherit pkgs;
        module = ../nixvim/config;
      })
      grimblast
      gimp
      qalculate-gtk
      eza
      inkscape
      calibre
      qbittorrent
      autossh
      ghostty
      colmena
      git-crypt
      devenv
      typst
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      nodejs_22
      (vscodium.fhsWithPackages (
        ps: with ps; [
          typstyle
          tinymist
        ]
      ))
    ]
    ++ nwgShellPrograms;

  programs = {
    home-manager.enable = true;

    git = {
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

    gh = {
      enable = true;
    };

    foot = import ./foot.nix;

    tealdeer = {
      enable = true;
      settings.auto_update = true;
    };

    firefox = {
      enable = true;
    };

    chromium = {
      enable = true;
    };

    mpv = {
      enable = true;
    };

    fish = import ./fish.nix attrs;

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };

  services.syncthing = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
  };
}
