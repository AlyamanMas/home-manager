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
    };

    git-credential-oauth = {
      enable = true;
    };

    # gh = {
    #   enable = true;
    # };
  };
}
