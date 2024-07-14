return  { 
    "Mofiqul/dracula.nvim", 
    priority = 1000 , -- Highest priority so nothing can override colorscheme 
  config = function()
    vim.cmd([[colorscheme dracula]])
  end
  }

