local M = {}

M.treesitter = {
  ensure_installed = {
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
    "svelte",
    "tsx",
    "twig",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    "arduino-language-server",
    "astro-language-server",
    "bash-language-server",
    "css-lsp",
    "cssmodules-language-server",
    "custom-elements-languageserver",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "eslint-lsp",
    "html-lsp",
    "jq",
    "json-lsp",
    "lua-language-server",
    "markdownlint",
    "nginx-language-server",
    "prettier",
    "pylint",
    "python-lsp-server",
    "rust-analyzer",
    "shfmt",
    "sql-formatter",
    "sqlfmt",
    "standardjs",
    "stylelint",
    "stylelint-lsp",
    "stylua",
    "svelte-language-server",
    "tailwindcss-language-server",
    "ts-standard",
    "typescript-language-server",
    "vim-language-server",
    "vue-language-server",
    "xmlformatter",
    "yaml-language-server",
    "yamlfmt",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },

  view = {
    adaptive_size = true,
  }
}

M.zenmode = {
  window = {
    width = 160,
  },
}

return M
