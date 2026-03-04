{
  config,
  ...
}:

let
  subdomainEntries =
    builtins.attrNames config.custom.reverseProxy.mappings |> map (subdomain: subdomain + ".localhost");
in
{
  networking.hosts = {
    "127.0.0.1" = subdomainEntries;
    "::1" = subdomainEntries;
  };
}
