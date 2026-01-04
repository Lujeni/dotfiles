return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"ansiblels",
				"bashls",
				"cssls",
				"djlsp",
				"dockerls",
				"eslint",
				"graphql",
				"helm_ls",
				"html",
				"htmx",
				"markdown_oxide",
				"lua_ls",
				"nginx_language_server",
				"pyrefly",
				"pyright",
				"rust_analyzer",
				"tailwindcss",
				"terraformls",
				"ts_ls",
				"vimls",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
				"ruff",
				"eslint_d",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
