{ pkgs, ... }:

{
  documentation.dev.enable = true;
  documentation.man.generateCaches = true;
  environment.systemPackages = with pkgs; [
    linux-manual
    man-pages
    man-pages-posix
  ];
}
