return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<C-n>", ":Neotree toggle=true position=bottom<CR>", { desc = "Open/Toggle neotree" })
	end,
	opts = {
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		window = {
			position = "bottom",
		},
	},
}
