_:

let
  palette = (import ../../common/themes/catppuccin.nix).currentPalette;
in
{
  services.mako = {
    enable = true;
    settings = {
      font = "Roboto 12";
      background-color = palette.mantle;
      text-color = palette.text;
      width = 600;
      padding = "20";
      border-radius = 30;
      border-color = palette.crust;
    };
  };
}
