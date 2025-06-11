{
  ...
}:

let
  palette = (import ../../common/themes/catppuccin.nix).currentPalette;
in
{
  services.mako = {
    enable = true;
    font = "Roboto 12";
    backgroundColor = palette.mantle;
    textColor = palette.text;
    width = 600;
    padding = "20";
    borderRadius = 30;
    borderColor = palette.crust;
  };
}
