lvim.leader = "space"

-- make Y yank the entire line include the cr
lvim.keys.normal_mode["Y"] = "Y";

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.which_key.mappings["f"] = {
  name = "+File",
  f = { "<cmd>Telescope find_files<cr>", "Find File" },
  g = { "<cmd>Telescope live_grep<cr>", "Grep File" },
};

lvim.builtin.which_key.mappings["t"] = { "<cmd>ToggleTerm direction=float<cr>", "Open Term" };
lvim.builtin.which_key.mappings["p"] = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" };
lvim.builtin.which_key.mappings["x"] = { "<cmd>nohlsearch<cr>", "Clear Search" };
lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "Zen Mode" };

-- key bindings for buffer/tabs
lvim.keys.normal_mode["<Tab>"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["[["] = "<cmd>BufferLineMovePrev<cr>" -- moves current buffer/tab left
lvim.keys.normal_mode["]]"] = "<cmd>BufferLineMoveNext<cr>" -- moves current bugger/tab right

vim.api.nvim_set_keymap(
  'n',
  '<C-p>',
  ":lua require'telescope'.extensions.project.project{}<CR>",
  { noremap = true, silent = true }
)
