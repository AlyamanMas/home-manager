{
  pkgs,
  ...
}:

{
  programs.fish = {
    enable = true;
    plugins = [
      {
        # Allows to source bash/shell scripts
        name = "bass";
        inherit (pkgs.fishPlugins.bass) src;
      }
      {
        name = "plugin-git";
        inherit (pkgs.fishPlugins.plugin-git) src;
      }
    ];
    shellInit = ''
      set -gx EDITOR nvim
    '';
    shellAliases = {
      U = "systemctl --user";
      S = "sudo systemctl";
      ndv = "nix develop --command fish";
      nrf = ''
        nix repl --expr "builtins.getFlake \"$PWD\""
      '';
      res = "sudo nixos-rebuild switch";
    };
  };
}
