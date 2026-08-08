{
  config,
  ...
}:

{
  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "20m";
    };
  };
}
