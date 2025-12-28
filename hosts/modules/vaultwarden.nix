_:

{
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://vw.tlsymposium.com";
      SIGNUPS_ALLOWED = false;

      # Vaultwarden currently recommends running behind a reverse proxy
      # (nginx or similar) for TLS termination, see
      # https://github.com/dani-garcia/vaultwarden/wiki/Hardening-Guide#reverse-proxying
      # > you should avoid enabling HTTPS via vaultwarden's built-in Rocket TLS support,
      # > especially if your instance is publicly accessible.
      #
      # A suitable NixOS nginx reverse proxy example config might be:
      #
      #     services.nginx.virtualHosts."bitwarden.example.com" = {
      #       enableACME = true;
      #       forceSSL = true;
      #       locations."/" = {
      #         proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      #       };
      #     };
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;

      ROCKET_LOG = "critical";
    };
  };
}
