{ pkgs, ... }:

{
  home = {
    username = "nix-on-droid";
    homeDirectory = "/data/data/com.termux.nix/files/homs";

    packages = with pkgs; [
      neovim
      git
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
