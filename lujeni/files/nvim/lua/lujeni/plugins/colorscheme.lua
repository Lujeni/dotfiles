return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "storm",
		})
		vim.cmd("colorscheme tokyonight")
	end,
}
