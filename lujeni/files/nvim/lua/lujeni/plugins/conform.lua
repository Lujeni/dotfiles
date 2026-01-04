return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			css = { "prettier" },
			graphql = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "ruff" },
			sh = { "shfmt" },
			yaml = { "prettier" },
		},
		format_on_save = {
			timeout_ms = 500,
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
		vim.keymap.set("n", "<leader>cf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format code" })
	end,
}
