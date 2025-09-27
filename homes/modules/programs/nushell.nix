{
  inputs,
  ...
}:
let
  palette = (import ../../../common/themes/catppuccin.nix).currentPalette;
  segmentBg = palette.surface0;
  segmentSeparator = palette.surface2;
  segmentFg = palette.text;
in
{
  programs.nushell = {
    enable = true;
    environmentVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      U = "systemctl --user";
      S = "sudo systemctl";
      ndv = "nix develop --command fish";
      nrf = ''
        nix repl --expr "builtins.getFlake \"$PWD\""
      '';
      res = "sudo nixos-rebuild switch";
    };
    extraConfig = ''
      # Fix transient prompt removing oh-my-posh prompt after entering a command
      # $env.TRANSIENT_PROMPT_COMMAND = $env.PROMPT_COMMAND
      # $env.TRANSIENT_PROMPT_COMMAND_RIGHT = $env.PROMPT_COMMAND_RIGHT
      # $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = $env.PROMPT_MULTILINE_INDICATOR
      overlay use ${inputs."git-aliases.nu"}/git-aliases.nu
    '';
  };
  programs.oh-my-posh = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      transient_prompt = {
        background = segmentBg;
        foreground = segmentFg;
        template = "{{ .PWD }}<${segmentBg},default></>";
        filler = "";
      };
      blocks = [
        {
          alignment = "left";
          segments = [
            {
              background = segmentBg;
              foreground = segmentFg;
              style = "plain";
              template = "  ";
              type = "root";
            }
            {
              background = segmentBg;
              foreground = segmentFg;
              properties = {
                style = "full";
              };
              style = "plain";
              template = " {{ .Path }} ";
              type = "path";
            }
            {
              background = segmentBg;
              foreground = segmentFg;
              style = "plain";
              template = "<${segmentSeparator}> </>{{ .HEAD }} ";
              type = "git";
            }
            {
              background = "transparent";
              foreground = segmentBg;
              style = "plain";
              template = "";
              type = "text";
            }
          ];
          type = "prompt";
        }
        {
          alignment = "left";
          newline = true;
          segments = [
            {
              foreground = palette.green;
              foreground_templates = [
                "{{ if gt .Code 0 }}${palette.green}{{ end }}"
              ];
              properties = {
                always_enabled = true;
              };
              style = "plain";
              template = "❯ ";
              type = "status";
            }
          ];
          type = "prompt";
        }
      ];
      version = 3;
    };
  };
}
