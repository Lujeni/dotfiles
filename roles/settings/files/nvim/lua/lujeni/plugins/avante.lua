return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = "*",
	opts = {
		provider = "copilot",
		copilot = {
			model = "claude-3.7-sonnet",
		},
		windows = {
			position = "right",
			width = 40,
		},
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"zbirenbaum/copilot.lua",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
				inline_code = false,
			},
			ft = { "markdown", "Avante" },
		},
	},
}
