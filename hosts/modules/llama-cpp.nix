{
  pkgsUnstable,
  ...
}:

{
  services.llama-cpp = {
    enable = true;
    host = "0.0.0.0";
    model = "/opt/models/qwen3.5-9b.gguf";
    package = pkgsUnstable.llama-cpp;
  };
}
