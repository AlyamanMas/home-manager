{ config, pkgs, ... }:

{
  imports = [
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    wget
    keepassxc
    nix-prefetch-scripts
    dconf-editor
  ];

  programs.git = {
    enable = true;
    userEmail = "alyaman.maasarani@gmail.com";
    userName = "Alyaman Massarani";
  };

  programs.gh = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    server.enable = true;
  };

  services.syncthing = {
    enable = true;
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
    ];
  };
}
