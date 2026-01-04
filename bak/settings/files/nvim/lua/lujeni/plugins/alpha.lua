return {
	"goolord/alpha-nvim",
	dependencies = { "echasnovski/mini.icons" },
	event = "VimEnter",
	config = function()
		require("alpha").setup(require("alpha.themes.startify").config)
	end,
}
