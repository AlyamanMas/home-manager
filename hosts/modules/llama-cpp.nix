{
  pkgsUnstable,
  ...
}:

{
  services.llama-cpp = {
    enable = true;
    host = "0.0.0.0";
    model = "/opt/models/Qwen3.6-27B-Q4_K_M.gguf";
    package = pkgsUnstable.llama-cpp;
    extraFlags = [
      "-c"
      "131072"
      "--temp"
      "0.6"
      "--top-p"
      "0.95"
      "--top-k"
      "20"
      "--min-p"
      "0.00"
      "--presence-penalty"
      "0.0"
      "--frequency-penalty"
      "0.0"
      "--repeat-penalty"
      "1.0"
      "-t" # threads
      "6"
      "-tb" # batch threads
      "16"
    ];
  };
}
