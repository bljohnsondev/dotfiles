---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- fix the yank mode
    ["Y"] = { "Y" },
    -- tmux navigation
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Window Left" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Window Right" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Window Down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Window Up" },
    -- trouble/problems
    ["<C-t>"] = { "<cmd>TroubleToggle<cr>", "Trouble Toggle" },
    -- lazygit
    ["<leader>gl"] = { "<cmd>LazyGit<cr>", "Toggle LazyGit" },
    -- zen mode
    ["<leader>zm"] = { "<cmd>ZenMode<cr>", "Zen Mode" },
    -- restart lsp
    ["<leader>lr"] = { "<cmd>LspRestart<cr>", "LSP Restart" },  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M
