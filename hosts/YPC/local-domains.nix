{
  config,
  lib,
  pkgs,
  nixpkgs-unstable,
  ...
}:

{
  networking.hosts = {
    "127.0.0.1" = [
      (lib.mkIf config.services.open-webui.enable "webui.local")
    ];
  };

  services.nginx = {
    enable = true;
    logError = "/var/log/nginx/error.log debug";
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "webui.local" = {
        serverName = "webui.local";
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://localhost:${builtins.toString config.services.open-webui.port}";
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;"
            # required when the server wants to use HTTP Authentication
            + "proxy_pass_header Authorization;";
        };
      };
    };
  };
}
