{
  environment.etcBackupExtension = ".bak";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "24.05";
}
