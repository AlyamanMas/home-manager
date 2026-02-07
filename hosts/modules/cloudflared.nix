{
  config,
  ...
}:

{
  services.cloudflared = {
    enable = true;
    # TODO: use sops
    certificateFile = ../../secrets/cloudflare/cert.pem;
    tunnels = {
      ${config.secrets.ypc3CloudflareTunnelId} = {
        # TODO: use sops
        credentialsFile = ../../secrets/cloudflare/tunnels/ypc3.json;
        default = "http_status:404";
        ingress = {
          "*.${config.secrets.ypc3CloudflareTunnelDomain}" = "http://localhost";
        };
      };
    };
  };
}
