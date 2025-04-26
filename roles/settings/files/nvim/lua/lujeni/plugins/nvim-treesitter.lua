return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufWritePost", "BufNewFile", "BufReadPre", "BufNewFile" },
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
      sync_install = false,
			-- ensure these language parsers are installed
			ensure_installed = {
				"bash",
				"c",
				"css",
				"diff",
				"dockerfile",
				"elixir",
				"gitignore",
				"graphql",
				"helm",
				"html",
				"htmldjango",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"make",
				"markdown",
				"markdown_inline",
				"nginx",
				"python",
				"query",
				"regex",
				"rst",
				"terraform",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
        "comment",
        "eex",
        "erlang",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "gleam",
        "ssh_config",
			},
		})
	end,
}
