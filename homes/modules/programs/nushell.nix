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
      $env.config.hooks.command_not_found = {
        |command_name|
        print (command-not-found $command_name | str trim)
      }
    '';
    settings = {
      completions.algorithm = "fuzzy";
      show_banner = false;
    };
  };
  programs.nix-your-shell = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = false;
  };
  home.shell.enableNushellIntegration = true;
  programs.oh-my-posh = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = false;
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
              template = "<${segmentSeparator}> </>{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }}{{ if and (.Staging.Changed) (.Working.Changed) }} |{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}";
              properties = {
                fetch_status = true;
                fetch_push_status = true;
              };
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
