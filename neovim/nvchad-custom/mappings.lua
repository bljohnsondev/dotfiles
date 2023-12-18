---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- fix the yank mode
    ["Y"] = { "Y" },
    -- tmux navigation
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "window left" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "window right" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "window up" },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M
