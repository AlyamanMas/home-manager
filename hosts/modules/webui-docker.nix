{
  config,
  pkgs,
  lib,
  ...
}:

{
  virtualisation.oci-containers.containers."open-webui" = {
    # ports = [ "1115:8080" ];
    # extraOptions = [ "--add-host=host.docker.internal:host-gateway" ];
    extraOptions = [ "--net=host" ];
    environment = {
      PORT = "1115";
    };
    volumes = [
      "open-webui:/app/backend/data"
    ];
    serviceName = "open-webui-docker";
    image = "ghcr.io/open-webui/open-webui:main";
  };
}
