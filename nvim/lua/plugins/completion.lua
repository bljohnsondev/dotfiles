return {
  {
    "saghen/blink.cmp",
    opts = {
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
