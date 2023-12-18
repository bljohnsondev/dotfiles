lvim.colorscheme = "tokyonight-night"

require("keymappings")

-- telescope config
lvim.builtin.telescope = {
  active = true,
  defaults = {
    file_ignore_patterns = { "node_modules" },
    layout_config = {
      horizontal = { height = 0.5 }
    }
  },
}

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.relativenumber = false

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = false,
  pattern = "*.lua",
  timeout = 1000,
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- removing eslint from the skipped servers so it works
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "eslint"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- formatters - in this case prettier
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "html", "css", "scss" },
  },
}

-- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>

lvim.plugins = {
  -- tokyo night theme
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- projects window in the telescope window - not really that useful
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
  },
  -- this is like the vs code "Problems" window
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  -- for lazy git
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- zen mode
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = .65
      }
    }
  },
  --- for rust
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end,
  }
}

-- install the telescope extension for projects
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "project")
end

-- this is the noice plugin - its cool but no sure how practical it is
--[[
lvim.plugins = {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,   -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,     -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
  }
}
]]
--
