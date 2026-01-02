return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"j-hui/fidget.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		vim.diagnostic.config({ virtual_text = true })
		require("fidget").setup({})
		require("mason").setup()

		vim.lsp.enable({
			"lua_ls",
			"pyright",
		})
	end,
	lazy = false,
}
