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
    ]
    ++ lib.optionals (config.device.host == "ypc3") [
      "io.github.dimtpap.coppwr" # basically pipewire graph patchpanel
      "org.signal.Signal"
      "eu.betterbird.Betterbird"
    ];
  };
}
