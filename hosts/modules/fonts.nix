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
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    material-symbols
    noto-fonts-cjk-sans
  ];
}
