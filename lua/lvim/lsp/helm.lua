local configs = require('lspconfig.configs')
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

if not configs.helm_ls then
  configs.helm_ls = {
    default_config = {
      cmd = {"helm_ls", "serve"},
      filetypes = {'helm'},
      root_dir = function(fname)
        return util.root_pattern('Chart.yaml')(fname)
      end,
    },
  }
end

lspconfig.helm_ls.setup {
  filetypes = {"helm"},
  cmd = {"helm_ls", "serve"},
}
-- Disable YAMLLS for Helm chart files
vim.cmd([[
  autocmd FileType yaml if getline(1) =~# '^#.*helm' | LspStop | endif
]])


-- Configure LSP with your custom on_attach
lspconfig.your_lsp_server.setup({
    on_attach = custom_on_attach,
    -- Other configuration options
})
