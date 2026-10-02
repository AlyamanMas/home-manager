{ ... }:
let
  # Plain mapping
  map = key: action: desc: {
    mode = "i";
    inherit key action;
    options = {
      silent = true;
      inherit desc;
    };
  };

  # Emacs-style case change: transforms the rest of the word at/after the
  # cursor (on the current line) and leaves the cursor at the end of it.
  caseMap = key: transform: desc: {
    mode = "i";
    inherit key;
    action.__raw = ''
      function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line = vim.api.nvim_get_current_line()
        local s, e = line:find("[%w_\128-\255]+", col + 1)
        if not s then
          return
        end
        local word = line:sub(s, e)
        local new = (${transform})(word)
        vim.api.nvim_buf_set_text(0, row - 1, s - 1, row - 1, e, { new })
        vim.api.nvim_win_set_cursor(0, { row, s - 1 + #new })
      end
    '';
    options = {
      silent = true;
      inherit desc;
    };
  };

  upcase = "function(w) return vim.fn.toupper(w) end";
  downcase = "function(w) return vim.fn.tolower(w) end";
  capitalize = ''
    function(w)
      return vim.fn.toupper(vim.fn.strcharpart(w, 0, 1))
        .. vim.fn.tolower(vim.fn.strcharpart(w, 1))
    end
  '';
in
{
  keymaps = [
    # Character movement
    (map "<C-b>" "<Left>" "Emacs: backward char")
    (map "<C-f>" "<Right>" "Emacs: forward char")

    # Line movement (blink-cmp handles these when its menu is open,
    # see the keymap in the blink config)
    (map "<C-n>" "<Down>" "Emacs: next line")
    (map "<C-p>" "<Up>" "Emacs: previous line")

    # Line start/end
    (map "<C-a>" "<Home>" "Emacs: beginning of line")
    (map "<C-e>" "<End>" "Emacs: end of line")

    # Deleting
    (map "<C-d>" "<Del>" "Emacs: delete char forward")
    (map "<M-d>" "<C-o>de" "Emacs: kill word forward")
    (map "<M-BS>" "<C-w>" "Emacs: kill word backward")
    (map "<C-k>" "<C-o>D" "Emacs: kill to end of line")

    # Word movement
    (map "<M-b>" "<C-Left>" "Emacs: backward word")
    (map "<M-f>" "<C-Right>" "Emacs: forward word")

    # Case changes
    (caseMap "<M-u>" upcase "Emacs: upcase word")
    (caseMap "<M-l>" downcase "Emacs: downcase word")
    (caseMap "<M-c>" capitalize "Emacs: capitalize word")

    # Undo (terminals usually send C-/ as C-_, so map both)
    (map "<C-/>" "<C-o>u" "Emacs: undo")
    (map "<C-_>" "<C-o>u" "Emacs: undo")
  ];
}
