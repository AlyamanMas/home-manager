{
  lib,
  pkgs,
  config,
  username,
  ...
}:

{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "e92c1110-6e6f-4be1-a257-f87b162de5cb" = {
        credentialsFile = "/home/${username}/.cloudflared/cert.pem";
        ingress = {
          "ysx.tlsymposium.com" = "http://localhost:8787";
        };
        default = "http_status:404";
      };
    };
  };
}
