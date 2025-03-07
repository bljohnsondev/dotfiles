return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- fix the yank mapping
          ["Y"] = { "Y" },

          -- toggle zen mode
          ["<leader>zz"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" },

          -- tab/shift-tab to navigate buffers
          ["<Tab>"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          ["<S-Tab>"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous buffer",
          },
        },
      },
    },
  },
}
