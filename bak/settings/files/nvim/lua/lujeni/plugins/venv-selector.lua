return {
	"linux-cultist/venv-selector.nvim",
	lazy = false,
	branch = "regexp", -- This is the regexp branch, use this for the new version
	config = function()
		require("venv-selector").setup()
	end,
	keys = {
		{ ",vs", "<cmd>VenvSelect<cr>" },
	},
}
