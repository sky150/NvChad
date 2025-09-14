**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!

### LSP Installation Troubleshooting (Common on Arch/CachyOS)
If `:MasonInstallAll` fails for Node-based LSPs (e.g., pyright, typescript-language-server, html-lsp, css-lsp):
1. Run `:checkhealth mason` and `:MasonLog` for details (e.g., "node not available" or "npm failed").
2. Reinstall dependencies:
   ```bash
   sudo pacman -Syu nodejs npm unzip wget curl gzip tar base-devel python python-pip
   npm cache clean --force
   pip install --user neovim
