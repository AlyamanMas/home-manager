{ config, pkgs, ... }:

{
  imports = [
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    wget
    keepassxc
  ];

  programs.git = {
    enable = true;
    userEmail = "alyaman.maasarani@gmail.com";
    userName = "Alyaman Massarani";
  };

  programs.fish = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    server.enable = true;
  };

  services.syncthing = {
    enable = true;
  };
}
