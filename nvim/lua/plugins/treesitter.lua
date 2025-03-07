-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "astro",
      "bash",
      "css",
      "dockerfile",
      "gitignore",
      "go",
      "html",
      "javascript",
      "jq",
      "jsdoc",
      "json",
      "kdl",
      "lua",
      "markdown",
      "markdown_inline",
      "nix",
      "php",
      "prisma",
      "python",
      "regex",
      "rust",
      "scss",
      "sql",
      "styled",
      "svelte",
      "tsx",
      "twig",
      "typescript",
      "vim",
      "vue",
      "yaml",
    })
  end,
}
