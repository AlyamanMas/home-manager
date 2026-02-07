{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.custom.reverseProxy;
in
{
  options.custom.reverseProxy = {
    enable = mkOption {
      type = types.bool;
      default = true; # If we are importing this module, then we must want to enable it; otherwise, there is no point in importing it
      description = "Whether to enable custom reverse proxy logic; basically map subdomain to localhost port or unix socket.";
    };
    provider = mkOption {
      type = types.enum [ "nginx" ];
      default = "nginx";
    };
    mappings = mkOption {
      type =
        with types;
        attrsOf (either port (addCheck str (x: hasPrefix "/" x || hasPrefix "unix:/" x)));
      description = ''
        Map a subdomain into either a local port number, a path, or a unix socket.
        Note that unix socket values must start with unix: (e.g. "unix:/run/forgejo/forgejo.sock"), and paths must start with a "/".
      '';
      default = { };
      example = ''
        {
          ow = 1115;
          fj = "unix:/run/forgejo/forgejo.sock";
        }
      '';
    };
  };

  # TODO: make this config in a way that allows it to work on all of my hosts. currently, need to handle:
  # - ssl configuration
  # - look into whether acme is needed or not. it doesn't seem needed?
  config = mkIf cfg.enable {
    services.nginx = {
      # logError = "stderr debug";
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts =
        let
          subdomainToFullDomain = domain: subdomain: subdomain + "." + domain;
          mappingAddrToNginxVirtHost = mappingAddr: {
            # sslCertificate = "/etc/ssl/certs/cf.crt";
            # sslCertificateKey = "/etc/ssl/private/cf.key";
            forceSSL = true;
            enableACME = true;
            locations."/" = {
              root = optionalDrvAttr (typeOf mappingAddr == "string" && (hasPrefix "/" mappingAddr)) mappingAddr;
              proxyPass =
                if (typeOf mappingAddr == "int") then
                  "http://127.0.0.1:${toString mappingAddr}"
                else if (typeOf mappingAddr == "string" && (hasPrefix "unix:/" mappingAddr)) then
                  "http://${mappingAddr}"
                else
                  null;
              proxyWebsockets =
                typeOf mappingAddr == "int" || (typeOf mappingAddr == "string" && (hasPrefix "unix:/" mappingAddr));
            };
          };
        in
        # TODO: be able to configure this module level?
        config.secrets.domains
        |> map (
          domain:
          cfg.mappings
          |> mapAttrs' (
            subdomain: addr: {
              name = subdomainToFullDomain domain subdomain;
              value = mappingAddrToNginxVirtHost addr;
            }
          )
        )
        |> foldl' (acc: attrs: acc // attrs) { };
    }; # end services.nginx
    security.acme = {
      acceptTerms = true;
      defaults.email = "alyaman.maasarani+acme@gmail.com";
    };
  };
}
