-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "ansiblels",
        "astro",
        "bashls",
        "biome",
        "cssls",
        "cssmodules_ls",
        "custom_elements_ls",
        "dockerls",
        "docker_compose_language_service",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "sqlls",
        "stylelint_lsp",
        "tailwindcss",
        "ts_ls",
        "yamlls",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        --[[
        "biome",
        "css-lsp",
        "cssmodules-language-server",
        "custom-elements-languageserver",
        "eslint-lsp",
        --"eslint_d",
        "html-lsp",
        --"prettier",
        "standardjs",
        "stylua",
        "stylelint",
        "stylelint-lsp",
        "ts-standard",
        "typescript-language-server",
        ]]--
        -- add more arguments for adding more null-ls sources
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        --"python",
        -- add more arguments for adding more debuggers
      })
    end,
  },
}
