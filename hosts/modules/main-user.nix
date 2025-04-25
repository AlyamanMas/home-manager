{
  username,
  lib,
  config,
  ...
}:

{
  options = {
    users.main-user = lib.mkOption {
      type = lib.types.str;
      default = "alyaman";
    };
  };

  config = {
    users.users.${config.users.main-user} = {
      isNormalUser = true;
      description = "Alyaman Massarani";
      extraGroups = [ "wheel" ];
    };
  };
}
