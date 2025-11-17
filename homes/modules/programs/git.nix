{
  pkgs,
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
        key = "6B2AF6605598965E";
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
