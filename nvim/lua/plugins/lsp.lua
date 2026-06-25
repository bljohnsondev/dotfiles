return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        vtsls = {
          settings = {
            typescript = { preferences = { quoteStyle = "single" } },
            javascript = { preferences = { quoteStyle = "single" } },
          },
        },
        cssls = {
          settings = {
            -- these are ignored for tailwind css at rules like @theme
            css = { lint = { unknownAtRules = "ignore" } },
            scss = { lint = { unknownAtRules = "ignore" } },
          },
        },
      },
    },
  },
}
