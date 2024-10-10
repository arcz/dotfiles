vim.cmd('packadd nvim-lspconfig')

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', require'telescope.builtin'.lsp_references, bufopts)
  vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gds', require'telescope.builtin'.lsp_document_symbols, bufopts)
  vim.keymap.set('n', 'gws', require'telescope.builtin'.lsp_workspace_symbols, bufopts)
  vim.keymap.set('n', 'cd', vim.diagnostic.goto_next, bufopts)

  vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  })

  --vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
  vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI", "InsertLeave"}, {
    pattern = "*",
    callback = function()
      vim.lsp.codelens.refresh()
    end,
  })
  vim.keymap.set("n", "cl", vim.lsp.codelens.run, bufopts)
end

require('lspconfig').rust_analyzer.setup({ on_attach = on_attach })
require('lspconfig').ts_ls.setup({ on_attach = on_attach })
require('lspconfig').gopls.setup({ on_attach = on_attach })
require('lspconfig').hls.setup({ on_attach = on_attach })
require('lspconfig').ccls.setup({ on_attach = on_attach })

require('lualine').setup({
  options = {
    icons_enabled = false,
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_c = { {
      'filename',
      path = 1,
      file_status = true,
    },
    { 'lsp_progress' }
    },
  }
})

require("ibl").setup() -- https://github.com/lukas-reineke/indent-blankline.nvim

-- https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#minimal-configuration
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Option 2: nvim lsp as LSP client
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
        -- you can add other fields for setting up lsp server in this table
    })
end
require('ufo').setup()
