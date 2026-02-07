{ pkgs, ... }:

{
  documentation.dev.enable = true;
  documentation.man.generateCaches = false;
  environment.systemPackages = with pkgs; [
    linux-manual
    man-pages
    man-pages-posix
  ];
}
