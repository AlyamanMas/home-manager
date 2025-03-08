{
  config,
  pkgs,
  lib,
  ...
}:

{
  virtualisation.oci-containers.containers."watchtower" = {
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
    ];
    serviceName = "watchtower-docker";
    image = "containrrr/watchtower";
  };
}
