{
  username,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-users = root ${username}
    '';
  };
}
