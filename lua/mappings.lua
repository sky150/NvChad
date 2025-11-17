require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- In your config
map("n", "gf", function()
  local file = vim.fn.expand("<cfile>")
  -- Handle import paths
  if file:match("^[.~@]") then
    vim.cmd("edit " .. file)
  else
    vim.cmd("normal! gf")
  end
end, { desc = "Go to file" })
