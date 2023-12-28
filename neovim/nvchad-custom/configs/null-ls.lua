local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {
  b.code_actions.eslint_d,
  b.formatting.eslint_d,
  b.diagnostics.eslint_d,

  --[[
  b.code_actions.eslint,
  b.formatting.eslint,
  b.diagnostics.eslint,
  ]]--
  --

  --[[
  b.code_actions.eslint_d,
  b.formatting.deno_fmt,
  b.diagnostics.eslint_d,
  ]]--

  --b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  --b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  --b.formatting.prettier,

  -- Lua
  b.formatting.stylua,

  -- cpp
  --b.formatting.clang_format,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
