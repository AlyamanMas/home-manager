{
  inputs,
  config,
  lib,
  ...
}:

{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./keepassxc-native-messaging-fix.nix
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
      "org.gnome.Music" # looks like it has been replaced by amberol? perhaps remove
      "org.gnome.Papers"
      "org.gnome.Solanum"
      "org.pulseaudio.pavucontrol"
      "io.github.Qalculate"
      "com.github.wwmm.easyeffects"
      "io.bassi.Amberol"
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
      "io.github.htkhiem.Euphonica" # mpd client in libadwaita
    ];

    # NOTE: apparently, next versions of flatpak-nix will switch `overrides` to `overrides.settings`,
    # but trying to use it right now with 0.7.0 throws an error.
    overrides = {
      global = {
        Context.filesystems = [
          # NOTE: flatpak does not use host fontconfig for some stupid reason.
          # instead, we have to copy the host fontconfig from /etc/fonts into
          # xdg-config/fontconfig, and then mount it in the flatpak container
          # like this. see the fonts hosts module.
          "xdg-config/fontconfig:ro"
        ];
      };
    };
  }; # end services.flatpak
}
