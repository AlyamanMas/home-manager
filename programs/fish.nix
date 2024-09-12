{
  config,
  pkgs,
  inputs,
  ...
}:

{
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
}
