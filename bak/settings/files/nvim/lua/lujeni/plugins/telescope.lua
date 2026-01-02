return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		"nvim-tree/nvim-web-devicons",
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
