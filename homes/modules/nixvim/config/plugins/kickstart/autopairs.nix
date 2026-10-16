{
  # Inserts matching pairs of parens, brackets, etc.
  # https://nix-community.github.io/nixvim/plugins/nvim-autopairs/index.html
  plugins.nvim-autopairs = {
    enable = true;
    luaConfig.post = /* lua */ ''
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.add_rules({
        -- $ -> $|$ in typst; typing $ before a closing $ jumps over it
        Rule("$", "$", "typst")
          :with_pair(cond.not_after_regex("%$"))
          :with_move(function(opts)
            return opts.next_char == opts.char
          end),

        -- space inside $|$ -> $ | $
        Rule(" ", " ", "typst")
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return pair == "$$"
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return context == "$  $"
          end),
      })
    '';
  };
}
