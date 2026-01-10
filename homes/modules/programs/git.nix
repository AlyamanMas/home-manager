{
  pkgs,
  config,
  ...
}:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
      settings = {
        user.email = "alyaman.maasarani@gmail.com";
        user.name = "Alyaman Massarani";
        credential = {
          helper = [ "${pkgs.gitFull}/bin/git-credential-libsecret" ];
        };
      };
      signing = {
        signByDefault = true;
        key =
          let
            deviceToGpgKey = {
              "YPC2" = "6B2AF6605598965E";
              "ypc3" = "515E428AC916D39C";
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

    diff-so-fancy = {
      enableGitIntegration = true;
      enable = true;
    };
    # gh = {
    #   enable = true;
    # };
  };
}
