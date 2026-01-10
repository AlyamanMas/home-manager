{
  # TODO: bump to 0.7.0 or above when it becomes stable
  nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
  # TODO: remove in favor of flatpak. perhaps do so too with other apps?
  zen-browser.url = "github:0xc000022070/zen-browser-flake";
  # TODO: remove; we are using breeze now
  rose-pine-hyprcursor = {
    url = "github:ndom91/rose-pine-hyprcursor";
    inputs.nixpkgs.follows = "nixpkgs";
    # inputs.hyprlang.follows = "hyprland/hyprlang";
  };
  "git-aliases.nu" = {
    url = "github:KamilKleina/git-aliases.nu";
    flake = false;
  };
  dms = {
    url = "github:AvengeMedia/DankMaterialShell/stable";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  # required for nix-on-droid until new versions are supported
  # TODO: remove anything related to nix-on-droid, since it seems like we are not going to use it
  nixpkgs-legacy.url = "github:NixOS/nixpkgs/nixos-24.05";
  nix-on-droid = {
    url = "github:nix-community/nix-on-droid/release-24.05";
    inputs.nixpkgs.follows = "nixpkgs-legacy";
  };
}
