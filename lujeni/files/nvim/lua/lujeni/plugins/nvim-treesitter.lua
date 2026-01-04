return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "master",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				"bash",
				"c",
				"comment",
				"css",
				"diff",
				"dockerfile",
				"elixir",
				"erlang",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"gleam",
				"graphql",
				"helm",
				"html",
				"htmldjango",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"nginx",
				"python",
				"query",
				"regex",
				"rst",
				"sql",
				"ssh_config",
				"terraform",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
