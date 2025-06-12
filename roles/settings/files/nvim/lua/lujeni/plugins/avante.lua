return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		windows = {
			width = 40, -- default % based on available width
		},
		behaviour = {
			auto_suggestions = false,
		},
		provider = "copilot",
		providers = {
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				model = "claude-sonnet-4",
				extra_request_body = {
					timeout = 30000,
					temperature = 0.75,
					max_tokens = 2048,
				},
			},
			copilot_completion = {
				__inherited_from = "copilot",
				model = "gpt4-turbo",
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}
