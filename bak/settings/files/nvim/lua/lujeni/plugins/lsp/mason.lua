return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jayp0521/mason-null-ls.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    mason.setup({
      ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "cssls",
        "dockerls",
        "elixirls",
        "lexical",
        "helm_ls",
        "helm_ls",
        "html",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "terraformls",
      },
      automatic_installation = true,
    })

--    local mason_null_ls = require("mason-null-ls")
--    mason_null_ls.setup({
--      -- list of formatters & linters for mason to install
--      ensure_installed = {
--        "prettier", -- ts/js formatter
--        "stylua", -- lua formatter
--        "eslint_d", -- ts/js linter
--      },
--      automatic_installation = true,
--    })
  end,
}

