{
  config,
  ...
}:

{
  services.ollama = {
    enable = true;
    acceleration =
      let
        hostname = config.networking.hostName;
      in
      if hostname == "ypc2" then
        "cuda"
      else if hostname == "ypc3" then
        "vulkan"
      else
        null;
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "20m";
    };
  };
}
