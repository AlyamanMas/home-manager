{
  config,
  pkgs,
  lib,
  ...
}:

{
  virtualisation.oci-containers.containers."open-webui" = {
    ports = [ "1115:8080" ];
    extraOptions = [ "--add-host=host.docker.internal:127.0.0.1" ];
    volumes = [
      "open-webui:/app/backend/data"
    ];
    serviceName = "open-webui-docker";
    image = "ghcr.io/open-webui/open-webui:main";
  };
}
