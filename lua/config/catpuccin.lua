-----------------------
-- Colorscheme Setup --
-----------------------
-- Using Colorscheme: Catppuccin
return { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000, -- Highest priority to make sure nothing overrrides
    config = function()
        vim.cmd([[colorscheme catppuccin-mocha]]) -- Colorscheme Theme set to Mocha (Extra-Dark)
    end
}
