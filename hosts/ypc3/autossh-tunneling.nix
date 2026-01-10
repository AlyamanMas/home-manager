# TODO: move into module as long as it is shared with ypc2
{
  pkgs,
  lib,
  ...
}:

{
  systemd.services.autossh-tunnel = {
    description = "AutoSSH session (socks-peer)";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Environment = [
        "AUTOSSH_GATETIME=0"
        "AUTOSSH_POLL=30"
        # "LOCALE_ARCHIVE=${pkgs.glibc_locales}/lib/locale/locale-archive"
        "PATH=${
          lib.makeBinPath [
            pkgs.coreutils
            pkgs.findutils
            pkgs.gnugrep
          ]
        }"
        "TZDIR=${pkgs.tzdata}/share/zoneinfo"
        "SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh"
      ];
      ExecStart = "${pkgs.autossh}/bin/autossh -M 20000 -ND 1333 -L 9050:127.0.0.1:9050 -L 9063:127.0.0.1:9063 alyaman@yvpsh.duckdns.org";
      User = "alyaman";
      Restart = "on-success";
    };
  };
}
