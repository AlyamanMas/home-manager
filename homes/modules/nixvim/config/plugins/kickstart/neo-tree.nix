{
  # Neo-tree is a Neovim plugin to browse the file system
  # https://nix-community.github.io/nixvim/plugins/neo-tree/index.html?highlight=neo-tree#pluginsneo-treepackage
  plugins.neo-tree = {
    enable = true;

    settings = {
      sources = [
        "filesystem"
        "document_symbols"
        "git_status"
      ];
      filesystem = {
        filtered_items = {
          visible = true;
          children_inherithighlights = true;
        };
        window = {
          mappings = {
            "\\" = "close_window";
          };
        };
      };
    };
  };

  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    {
      key = "\\";
      action = "<cmd>Neotree reveal<cr>";
      options = {
        desc = "NeoTree reveal";
      };
    }
  ];
}
