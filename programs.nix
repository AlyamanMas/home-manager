{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wget
    keepassxc
  ];

  programs.git = {
    enable = true;
    userEmail = "alyaman.maasarani@gmail.com";
    userName = "Alyaman Massarani";
  };
}
