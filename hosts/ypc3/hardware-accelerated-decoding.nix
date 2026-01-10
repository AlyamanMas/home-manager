{
  pkgs,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    ];
  };
  # NOTE: intel-vaapi-driver still performs better for browsers (gecko/chromium based) on newer Skylake (2015) processors. from https://wiki.nixos.org/wiki/Accelerated_Video_Playback
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  }; # Optionally, set the environment variable
}
