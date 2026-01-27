{
  config,
  ...
}:

let
  username = config.users.mainUser;
in
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes pipe-operators
      trusted-users = root ${username}
    '';
  };
}
