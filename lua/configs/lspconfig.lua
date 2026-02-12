local nvlsp = require "nvchad.configs.lspconfig"

-- 1. NATIVE HELPER (With safer root detection)
local function start(config)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = config.filetypes,
    callback = function(ev)
      -- Safer root detection: Default to CWD, then try to find package.json
      local root = vim.loop.cwd()
      if ev.file and ev.file ~= "" then
        local found = vim.fs.find({ "package.json", ".git" }, { path = ev.file, upward = true })[1]
        if found then
          root = vim.fs.dirname(found)
        end
      end

      local client_config = vim.tbl_deep_extend("force", {
        name = config.name,
        cmd = config.cmd,
        root_dir = root,
        capabilities = nvlsp.capabilities,
        on_attach = nvlsp.on_attach,
        on_init = nvlsp.on_init,
        settings = config.settings,
        init_options = config.init_options,
      }, config.overrides or {})

      vim.lsp.start(client_config)
    end,
  })
end

-- ==========================================================
-- 2. SERVER LIST
-- ==========================================================

-- A. Simple Servers
start { name = "html", cmd = { "vscode-html-language-server", "--stdio" }, filetypes = { "html" } }
start { name = "cssls", cmd = { "vscode-css-language-server", "--stdio" }, filetypes = { "css", "scss" } }
start {
  name = "tailwindcss",
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "astro", "typescriptreact", "javascriptreact", "html", "css" },
}
start { name = "gopls", cmd = { "gopls" }, filetypes = { "go", "gomod" } }
start {
  name = "pyright",
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
}
-- B. ESLint (THE FIX IS HERE)
start {
  name = "eslint",
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
  settings = {
    -- These settings prevent the "path undefined" crash
    codeActionOnSave = { enable = false, mode = "all" },
    experimental = { useFlatConfig = false },
    format = false,
    nodePath = "",
    quiet = false,
    run = "onType",
    validate = "on",
    workingDirectory = { mode = "auto" },
  },
}

-- C. TypeScript / React
start {
  name = "ts_ls",
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  init_options = {
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsWithInsertText = true,
      importModuleSpecifierPreference = "non-relative",
    },
  },
}

-- D. Astro
start {
  name = "astro",
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  init_options = {
    typescript = {
      tsdk = vim.fn.stdpath "data" .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
    },
  },
}
