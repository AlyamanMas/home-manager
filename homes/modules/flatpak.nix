{
  inputs,
  ...
}:

{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "org.signal.Signal"
      "com.bitwarden.desktop"
      "eu.betterbird.Betterbird"
      "com.obsproject.Studio"
      "app.zen_browser.zen"
      "us.zoom.Zoom"
    ];
  };
}
