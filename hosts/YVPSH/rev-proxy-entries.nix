{ config, ... }:

{
  custom.reverseProxy.mappings = {
    webui = config.services.open-webui.port;
    timer = "/www/aucsymposium/timer/";
  };

  services.nginx = {
    virtualHosts = {
      "tlsymposium.com" = {
        sslCertificate = "/etc/ssl/certs/cf.crt";
        sslCertificateKey = "/etc/ssl/private/cf.key";
        forceSSL = true;
        locations."/" = {
          root = "/www/aucsymposium/timer/";
        };
      };
      "matrix.tlsymposium.com" = {
        sslCertificate = "/etc/ssl/certs/cf.crt";
        sslCertificateKey = "/etc/ssl/private/cf.key";
        forceSSL = true;
        # Location for client auto-discovery
        locations."/.well-known/matrix/client" = {
          extraConfig = ''
            add_header Content-Type application/json;
            return 200 '{"m.homeserver": {"base_url": "https://matrix.tlsymposium.com"}, "org.matrix.msc4143.rtc_foci": [{"type": "livekit", "livekit_service_url": "https://livekit-jwt.call.matrix.org"}]}';
          '';
        };
        # Recommended location for server federation discovery
        locations."/.well-known/matrix/server" = {
          extraConfig = ''
            add_header Content-Type application/json;
            add_header "Access-Control-Allow-Origin" "*"; # For federation tester
            return 200 '{"m.server": "matrix.tlsymposium.com:443"}';
          '';
        };
        locations."/" = {
          proxyPass = "http://127.0.0.1:8448";
          proxyWebsockets = true; # needed if you need to use WebSocket
          extraConfig =
            # required when the target is also TLS server with multiple hosts
            "proxy_ssl_server_name on;"
            +
              # required when the server wants to use HTTP Authentication
              "proxy_pass_header Authorization;";
        };
      };
    }; # end virtualHosts
  };
}
