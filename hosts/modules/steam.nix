{
  pkgsUnstable,
  ...
}:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgsUnstable; [
      proton-ge-bin
    ];
  };
}
