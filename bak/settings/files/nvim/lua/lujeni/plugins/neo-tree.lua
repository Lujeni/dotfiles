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
			default_component_configs = {
				type = { enable = false },
				size = { enable = false },
				modified = { enable = false },
			},

			renderers = {
				filesystem = {
					directory = {
						{ "indent" },
						{ "icon" },
						{ "name", trailing_slash = true },
					},
					file = {
						{ "indent" },
						{ "icon" },
						{ "name" },
					},
				},
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<C-n>", ":Neotree toggle=true<CR>", { desc = "Open/Toggle neotree" })
	end,
}
