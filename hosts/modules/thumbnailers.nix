{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpeg-headless
    ffmpegthumbnailer
    gdk-pixbuf
    # For general HEIF container support (this includes the AVIF file format)
    libheif.bin # provides heif-thumbnailer (the program that generates HEIF thumbnails)
    libheif.out # provides heif.thumbnailer (allows for the viewing of HEIF thumbnails)

    # For more newer AVIF specific support usually not needed if libheif is installed
    libavif

    # For JXL(JPEG XL) support
    libjxl

    # For WebP support
    webp-pixbuf-loader

    # for 3d models
    # pkgs.f3d
  ];
  # All of the thumbnailers are created in '/run/current-system/sw/share/thumbnailers'
}
