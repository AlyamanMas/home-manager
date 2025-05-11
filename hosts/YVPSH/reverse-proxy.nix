{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # TODO: change these definitions to only work when the service is enabled.
    virtualHosts = {
      #"tlsymposium.com" = {
      #  sslCertificate = "/etc/ssl/certs/cf.crt";
      #  sslCertificateKey = "/etc/ssl/private/cf.key";
      #  forceSSL = true;
      #  locations."/" = {
      #    proxyPass = "http://127.0.0.1:8075";
      #    proxyWebsockets = true; # needed if you need to use WebSocket
      #    extraConfig =
      #      # required when the target is also TLS server with multiple hosts
      #      "proxy_ssl_server_name on;"
      #      +
      #        # required when the server wants to use HTTP Authentication
      #        "proxy_pass_header Authorization;";
      #  };
      #};
      "vw.tlsymposium.com" = {
        sslCertificate = "/etc/ssl/certs/cf.crt";
        sslCertificateKey = "/etc/ssl/private/cf.key";
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;"
            +
              # required when the server wants to use HTTP Authentication
              "proxy_pass_header Authorization;";
        };
      };
      "wui.tlsymposium.com" = {
        sslCertificate = "/etc/ssl/certs/cf.crt";
        sslCertificateKey = "/etc/ssl/private/cf.key";
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:1115";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;"
            +
              # required when the server wants to use HTTP Authentication
              "proxy_pass_header Authorization;";
        };
      };
      "jp.tlsymposium.com" = {
        sslCertificate = "/etc/ssl/certs/cf.crt";
        sslCertificateKey = "/etc/ssl/private/cf.key";
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:10010";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;"
            +
              # required when the server wants to use HTTP Authentication
              "proxy_pass_header Authorization;";
        };
      };
      "sxng.tlsymposium.com" = {
        sslCertificate = "/etc/ssl/certs/cf.crt";
        sslCertificateKey = "/etc/ssl/private/cf.key";
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8787";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;"
            +
              # required when the server wants to use HTTP Authentication
              "proxy_pass_header Authorization;";
        };
      };
      "gitea.tlsymposium.com" = {
        sslCertificate = "/etc/ssl/certs/cf.crt";
        sslCertificateKey = "/etc/ssl/private/cf.key";
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.gitea.settings.server.HTTP_PORT}";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;"
            +
              # required when the server wants to use HTTP Authentication
              "proxy_pass_header Authorization;";
        };
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "alyaman.maasarani+acme@gmail.com";
  };
}
