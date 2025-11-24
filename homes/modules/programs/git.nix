{
  pkgs,
  config,
  ...
}:
{
  programs = {
    git = {
      enable = true;
      userEmail = "alyaman.maasarani@gmail.com";
      userName = "Alyaman Massarani";
      package = pkgs.gitFull;
      extraConfig = {
        credential = {
          helper = [ "${pkgs.gitFull}/bin/git-credential-libsecret" ];
        };
      };
      diff-so-fancy = {
        enable = true;
      };
      signing = {
        signByDefault = true;
        key =
          let
            deviceToGpgKey = {
              "YPC2" = "6B2AF6605598965E";
              "YPC3" = "515E428AC916D39C";
            };
          in
          deviceToGpgKey.${config.device.host}
            or (throw "config.device does not have a key for signing in git.");
        format = "openpgp";
      };
    };

    git-credential-oauth = {
      enable = true;
    };

    # gh = {
    #   enable = true;
    # };
  };
}
