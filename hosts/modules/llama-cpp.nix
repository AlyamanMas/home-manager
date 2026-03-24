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
    extraFlags = [
      "-c"
      "262144"
      "--temp"
      "0.6"
      "--top-p"
      "0.95"
      "--top-k"
      "20"
      "--min-p"
      "0.00"
    ];
  };
}
