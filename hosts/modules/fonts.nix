{
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    iosevka
    open-sans
    inter
    fantasque-sans-mono
    roboto
    corefonts
    vistafonts
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];
}
