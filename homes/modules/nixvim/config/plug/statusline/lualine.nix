{ config, lib, ... }:
let
  colors = import ../../colors/${config.theme}.nix { };
  helpers = lib.nixvim;
in
{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
        theme = {
          normal = {
            a = {
              bg = "#nil";
            };
            b = {
              bg = "nil";
            };
            c = {
              bg = "nil";
            };
            z = {
              bg = "nil";
            };
            y = {
              bg = "nil";
            };
          };
        }; # end theme
        disabled_filetypes = {
          statusline = [
            "dashboard"
            "alpha"
            "starter"
          ];
        };
      }; # end options
      inactive_sections = {
        lualine_x = [
          "filename"
          "filetype"
        ];
      };
      sections = {
        lualine_a = [
          (
            helpers.listToUnkeyedAttrs [ "mode" ]
            // {
              fmt = "string.lower";
              color = {
                fg = if config.colorschemes.base16.enable then colors.base04 else "nil";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          )
        ];
        lualine_b = [
          (
            helpers.listToUnkeyedAttrs [ "branch" ]
            // {
              icon = "";
              color = {
                fg = if config.colorschemes.base16.enable then colors.base04 else "nil";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          )
          (
            helpers.listToUnkeyedAttrs [ "diff" ]
            // {
              separator.left = "";
              separator.right = "";
            }
          )
        ];
        lualine_c = [
          (
            helpers.listToUnkeyedAttrs [ "diagnostic" ]
            // {
              symbols = {
                error = " ";
                warn = " ";
                info = " ";
                hint = "󰝶 ";
              };
              color = {
                fg = if config.colorschemes.base16.enable then colors.base08 else "nil";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          )
        ];
        lualine_x = [ "" ];
        lualine_y = [
          (
            helpers.listToUnkeyedAttrs [ "filetype" ]
            // {
              icon_only = true;
              separator.left = "";
              separator.right = "";
            }
          )
          (
            helpers.listToUnkeyedAttrs [ "filename" ]
            // {
              symbols = {
                modified = "";
                readonly = "👁️";
                unnamed = "";
              };
              color = {
                fg = if config.colorschemes.base16.enable then colors.base05 else "nil";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          )
        ];
        lualine_z = [
          (
            helpers.listToUnkeyedAttrs [ "location" ]
            // {
              color = {
                fg = if config.colorschemes.base16.enable then colors.base0B else "nil";
                bg = "nil";
              };
              separator.left = "";
              separator.right = "";
            }
          )
        ];
      };
    }; # end settings
  };
}
