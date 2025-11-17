-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"
-- Using the NEW vim.lsp.config() syntax for Neovim 0.11+
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "tailwindcss",
  "jsonls",
  "lua_ls",
  "eslint",
  "pyright",
  "clangd",
  "gopls"
}


-- Setup servers using vim.lsp.config (NEW way)
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
end

-- Optional: Add Go-specific settings for gopls
vim.lsp.config("gopls", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

-- Backup: Auto-start gopls for Go files (in case vim.lsp.config doesn't trigger)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    -- Check if gopls is already attached
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.name == "gopls" then
        return  -- Already attached, don't start again
      end
    end
    -- Start gopls
    vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      root_dir = vim.fs.dirname(vim.fs.find({ "go.mod", "go.work", ".git" }, { upward = true })[1]),
    })
  end,
})
