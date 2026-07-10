return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
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
