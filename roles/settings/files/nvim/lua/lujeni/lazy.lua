local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
    -- disable lsp watcher. Too slow on linux
    wf._watchfunc = function()
      return function() end
    end
end

require("lazy").setup({{import = "lujeni.plugins"}, {import = "lujeni.plugins.lsp"}}, {
  install = {
    colorscheme = { "tokyonight-storm" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
