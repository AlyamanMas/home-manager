{ pkgs, ... }:

{
  documentation.dev.enable = true;
  documentation.man.generateCaches = false;
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
}
