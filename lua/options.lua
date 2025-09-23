require "nvchad.options"

-- add yours here!

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown", "text" },
	callback = function()
		vim.wo.conceallevel = 1
	end,
})

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

local opt = vim.opt
opt.termguicolors = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
