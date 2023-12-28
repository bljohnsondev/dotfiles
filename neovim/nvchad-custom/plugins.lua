local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		--opts = overrides.mason
		opts = {
			ensure_installed = {
				"arduino-language-server",
				"astro-language-server",
				"bash-language-server",
				"css-lsp",
				"cssmodules-language-server",
				"custom-elements-languageserver",
				"docker-compose-language-service",
				"dockerfile-language-server",
				"eslint-lsp",
				"html-lsp",
				"jq",
				"json-lsp",
				"lua-language-server",
				"markdownlint",
				"nginx-language-server",
				"prettier",
				"pylint",
				"python-lsp-server",
				"rust-analyzer",
				"shfmt",
				"sql-formatter",
				"sqlfmt",
				"standardjs",
				"stylelint",
				"stylelint-lsp",
				"stylua",
				"svelte-language-server",
				"tailwindcss-language-server",
				"ts-standard",
				"typescript-language-server",
				"vim-language-server",
				"vue-language-server",
				"xmlformatter",
				"yaml-language-server",
				"yamlfmt",
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		--opts = overrides.treesitter,
		opts = {
			ensure_installed = {
				"astro",
				"bash",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"html",
				"javascript",
				"jq",
				"jsdoc",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"nix",
				"php",
				"prisma",
				"python",
				"regex",
				"rust",
				"scss",
				"sql",
				"svelte",
				"tsx",
				"twig",
				"typescript",
				"vim",
				"vue",
				"yaml",
			},
		},
	},

	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		opts = overrides.nvimtree,
		config = function()
			require("nvim-tree").setup({
				view = {
          adaptive_size = true,
				},
			})
		end,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		lazy = false,
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},
	{
		"folke/zen-mode.nvim",
		lazy = false,
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }
}

return plugins
