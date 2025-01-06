# WARN: this file will get overwritten by $ cachix use <name>
{ pkgs, lib, ... }:

{
  imports = [
    ./cuda-maintainers.nix
  ];
  nix.settings.substituters = [ "https://cache.nixos.org/" ];
}
