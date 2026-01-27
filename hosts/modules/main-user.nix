{
  lib,
  config,
  ...
}:

{
  options = {
    users.mainUser = lib.mkOption {
      type = lib.types.str;
      default = "alyaman";
    };
  };

  config = {
    users.users.${config.users.mainUser} = {
      isNormalUser = true;
      description = "Alyaman Massarani";
      extraGroups = [ "wheel" ];
    };
  };
}
