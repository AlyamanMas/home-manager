{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    # The alternative would be conform
    lsp-format.enable = true;

    lsp = {
      enable = true;
      servers = {
        nil-ls = {
          enable = true;
        };
        nixd = {
          enable = true;
        };
      };
    };
  };
}
