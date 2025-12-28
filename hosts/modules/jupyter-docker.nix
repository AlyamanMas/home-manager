_:

{
  virtualisation.oci-containers.containers."jupyter" = {
    ports = [ "10010:8888" ];
    volumes = [
      "jupyter-home:/home/jovyan"
    ];
    entrypoint = "start-notebook.py";
    cmd = [
      "--ip=0.0.0.0"
      "--no-browser"
      "--allow-root"
      "--NotebookApp.disable_check_xsrf=True"
    ];
    serviceName = "jupyter-docker";
    image = "quay.io/jupyter/scipy-notebook";
  };
}
