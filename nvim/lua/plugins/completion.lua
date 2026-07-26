return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        -- Only accepts if an item was explicitly selected via Tab/S-Tab (preselect = false
        -- below means nothing is selected by default)
        ["<CR>"] = { "accept", "fallback" },
      },
      completion = {
        list = {
          selection = {
            -- Don't auto-select the first item; require explicit selection
            -- via arrow keys or Tab before Enter confirms a completion.
            preselect = false,
          },
        },
      },
    },
  },
}
