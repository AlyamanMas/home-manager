# TODO: move relevant programs to modules
{
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  editorDepsFunc =
    ps: with ps; [
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
  vimDeps = editorDepsFunc pkgs;
  nvimWithDeps = vimDeps ++ [ pkgs.neovim-unwrapped ];
  vscodium = pkgs.vscodium.fhsWithPackages editorDepsFunc;
  zed = pkgs.zed-editor.fhsWithPackages editorDepsFunc;
  open-last-screenshot = pkgs.writeScriptBin "open-last-screenshot.nu" /* nu */ ''
    #!/usr/bin/env nu
    ls $"($env.HOME)/Pictures/Screenshots/" | sort-by modified -r | get 0.name | xdg-open $in
  '';
  devTools = with pkgs; [
    # nix {{{
    nixfmt
    nix-prefetch-scripts
    nix-prefetch-github
    devenv
    #}}}
    # python {{{
    uv
    ruff
    python3
    # }}}
    # git {{{
    git-crypt
    lazygit
    #}}}
    typst
    nodejs_22
  ];
  cliTools = with pkgs; [
    # networking {{{
    wget
    aria2
    autossh
    nftables
    dig
    nettools
    sshfs
    socat
    # }}}
    # filesystem {{{
    ripgrep
    fd
    fzf
    borgbackup
    # }}}
    # wayland/display {{{
    wl-clipboard
    brightnessctl
    # }}}
    # media {{{
    yt-dlp
    ffmpeg
    imagemagick
    # }}}
    # system {{{
    btop
    playerctl
    libnotify
    usbutils
    pciutils
    appimage-run
    android-tools
    scrcpy
    claude-code
    file
    # }}}
    # documents {{{
    poppler-utils
    pandoc
    # }}}
    # games {{{
    lsfg-vk
    lsfg-vk-ui
    # }}}
  ];
  graphicalApps = with pkgs; [
    qbittorrent # TODO: move to flatpak
    zathura # TODO: move to flatpak when released
    networkmanagerapplet
    open-last-screenshot
    wev
    inputs.helium.packages.${system}.default # TODO: move to flatpak when released
    vscodium
    zed
  ];
in
{
  home.packages = devTools ++ cliTools ++ graphicalApps ++ nvimWithDeps;

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

    direnv = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
# vim: foldmethod=marker
