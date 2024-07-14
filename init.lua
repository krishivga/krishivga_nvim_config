-- LazyVim Installation

local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim" -- Checking if lazyvim is installed
if not vim.loop.fs_stat(lazypath) then -- If it isn't installed, it begins with installation
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", -- Clones the lazyvim repository from github
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Importing options
require("vim-options")

-- Importing Plugins
require("lazy").setup("plugins")

