return {
	"b0o/incline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		window = {
			padding = 0,
			margin = { horizontal = 0 },
		},
		render = function(props)
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")

			-- get filename (tail)
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			if filename == "" then
				filename = "[No Name]"
			end

			-- try to get icon + color
			local ft_icon, ft_color = devicons.get_icon_color(filename)
			local modified = vim.bo[props.buf].modified

			-- build the components table
			return {
				-- icon, if any
				ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
				" ",
				-- filename (bold; italic if modified)
				{ filename, gui = modified and "bold,italic" or "bold" },
				" ",
				-- background for the whole window
				guibg = "#44406e",
			}
		end,
	},
}
