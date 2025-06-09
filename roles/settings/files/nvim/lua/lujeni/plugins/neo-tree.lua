return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				position = "bottom",
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<C-n>", ":Neotree toggle=true<CR>", { desc = "Open/Toggle neotree" })
	end,
}
