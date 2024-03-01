return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      auto_expand_width = true,
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    }
  }
}
