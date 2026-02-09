{
  inputs,
  config,
  lib,
  ...
}:

{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "com.bitwarden.desktop"
      "com.obsproject.Studio"
      "app.zen_browser.zen"
      "us.zoom.Zoom"
      "com.github.tchx84.Flatseal"
      "org.keepassxc.KeePassXC"
      "org.gnome.Music"
      "org.gnome.Papers"
      "org.gnome.Solanum"
      "org.pulseaudio.pavucontrol"
      "io.github.Qalculate"
      "com.github.wwmm.easyeffects"
    ]
    ++ lib.optionals (config.device.host == "ypc3") [
      "io.github.dimtpap.coppwr" # basically pipewire graph patchpanel
      "org.signal.Signal"
      "eu.betterbird.Betterbird"
      "org.libreoffice.LibreOffice"
      "org.zotero.Zotero"
      "org.gimp.GIMP"
      "org.inkscape.Inkscape"
      "com.getpostman.Postman"
      "org.kde.okular"
      "md.obsidian.Obsidian"
      "ca.desrt.dconf-editor"
      "org.onlyoffice.desktopeditors"
    ];

    overrides = {
      global = {
        Context.filesystems = [
          # NOTE: flatpak does not use host fontconfig for some stupid reason.
          # instead, we have to copy the host fontconfig from /etc/fonts into
          # xdg-config/fontconfig, and then mount it in the flatpak container
          # like this. see the fonts hosts module.
          "xdg-config/fontconfig"
        ];
      };
    };
  };
}
