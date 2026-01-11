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
      u = "systemctl --user";
      s = "sudo systemctl";
      ndv = "nix develop --command fish";
      nrf = ''
        nix repl --expr "builtins.getFlake \"$PWD\""
      '';
      nrs = "sudo nixos-rebuild switch";
      hms = "home-manager --flake ~/projects/nix/config/ switch";
      lg = "lazygit";
    };
  };
}
