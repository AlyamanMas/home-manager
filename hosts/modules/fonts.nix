{
  pkgs,
  inputs,
  ...
}:

{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      iosevka
      open-sans
      inter
      fantasque-sans-mono
      roboto
      corefonts
      vista-fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      material-symbols
      noto-fonts-cjk-sans
      noto-fonts
      vazir-fonts
      adwaita-fonts
      # TODO: replace with nixpkgs packages when nunito is merged into nixpkgs
      inputs.nixpkgs-alyamanmas.legacyPackages.x86_64-linux.nunito
      inputs.nixpkgs-alyamanmas.legacyPackages.x86_64-linux.nunito-sans
    ];

    # NOTE: in flatpak, fontconfig options are not taken into account, and
    # instead flatpak containers use their own fontconfig configuration.
    # futhermore, trying to bind /etc/fonts to system version does not work.
    # the solution is to use user-level fontconfig at xdg-config/fontconfig,
    # and then bind that to flatpak configurations
    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Adwaita Sans"
          "Vazirmatn UI"
        ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };
}
