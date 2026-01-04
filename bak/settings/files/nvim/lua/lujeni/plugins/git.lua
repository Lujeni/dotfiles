return {
  {"tpope/vim-fugitive"},
  {
      "lewis6991/gitsigns.nvim",
      event = {"BufReadPre", "BufNewFile"},
      opts = {
          signs = {
              add = {text = "▎"},
              change = {text = "▎"},
              delete = {text = ""},
              topdelete = {text = ""},
              changedelete = {text = "▎"},
              untracked = {text = "▎"}
          },
          on_attach = function(buffer)
              local gs = package.loaded.gitsigns
          end
      }
  }
}
