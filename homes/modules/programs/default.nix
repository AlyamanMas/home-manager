{
  pkgs,
  inputs,
  ...
}@attrs:
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
      inputs.zen-browser.outputs.packages.x86_64-linux.default
      # (inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
      #   inherit pkgs;
      #   module = ../nixvim/config;
      # })
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
    ]
    ++ vimDeps;

  programs = {
    home-manager.enable = true;

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

    # TODO: fix this into normal nix module
    fish = import ./fish.nix attrs;

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

  # services.syncthing = {
  #   enable = true;
  # };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [ distroav ];
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };
}
