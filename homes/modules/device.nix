{
  lib,
  ...
}:

{
  options = {
    device.host = lib.mkOption {
      type = lib.types.str;
    };
  };
}
