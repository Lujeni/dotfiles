return {
	"nvim-telescope/telescope.nvim",
	version = "0.2.1",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			pickers = {
				find_files = {
					theme = "dropdown",
					hidden = true,
				},
				live_grep = {
					additional_args = { "--hidden" },
				},
			},
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
					},
				},
			},
		})
		telescope.load_extension("fzf")
		local telescope_builtin = require("telescope.builtin")
		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Fuzzy find recent files" })
	end,
}
