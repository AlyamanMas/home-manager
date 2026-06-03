{ inputs, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit system;
  module = import ./config;
}
