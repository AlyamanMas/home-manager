{
  config,
  ...
}:

let
  username = config.users.main-user;
in
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-users = root ${username}
    '';
  };
}
