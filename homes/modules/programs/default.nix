{
  pkgs,
  inputs,
  ...
}:
let
  vimDeps = with pkgs; [
    neovim-unwrapped
    stylua
    gcc
    lua-language-server
    nixd
    basedpyright
    nil
    vscode-langservers-extracted
    tailwindcss-language-server
    svelte-language-server
    typescript-language-server
    emmet-language-server
    tinymist
    markdown-oxide
    bash-language-server
    shellcheck
    shfmt
  ];
  open-last-screenshot = pkgs.writeScriptBin "open-last-screenshot.nu" /* nu */ ''
    #!/usr/bin/env nu
    ls $"($env.HOME)/Pictures/Screenshots/" | sort-by modified -r | get 0.name | xdg-open $in
  '';
in
{

  imports = [
    ./nushell.nix
    ./foot.nix
    ./git.nix
  ];

  home.packages =
    with pkgs;
    [
      wget
      keepassxc
      nix-prefetch-scripts
      # dconf-editor
      # gnome-tweaks
      nixfmt-rfc-style
      ripgrep
      libreoffice-qt
      wl-clipboard
      papers
      gnome-music
      zotero_7
      # jetbrains.pycharm-professional
      yt-dlp
      ffmpeg
      gnome-solanum
      # kitty
      wofi
      fd
      btop
      pavucontrol
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
      zathura
      zellij
      postman
      rofi-unwrapped
      openai-whisper
      (zed-editor.fhsWithPackages (
        ps: with ps; [
          typstyle
          tinymist
          nil
          ruff
          python3
          pyright
          uv
          go
          gopls
          package-version-server
        ]
      ))
      brightnessctl
      iptables
      kdePackages.okular
      lazygit
      obsidian
      uv
      ruff
      python3
      playerctl
      android-studio
      jdk17_headless
      networkmanagerapplet
      open-last-screenshot
      fzf
      dig
      libnotify
      poppler-utils
      imagemagick
      dconf-editor
      usbutils
      pciutils
      wev
      nettools
      sshfs
      socat
      pandoc
      appimage-run
      inputs.helium.packages.${system}.default
      android-tools
      scrcpy
    ]
    ++ vimDeps;

  programs = {
    home-manager.enable = true;

    tealdeer = {
      enable = true;
      settings.auto_update = true;
    };

    mpv = {
      enable = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = false;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };
}
