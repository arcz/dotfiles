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

  vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  })
end

require('lspconfig').rust_analyzer.setup({ on_attach = on_attach })
require('lspconfig').tsserver.setup({ on_attach = on_attach })
require('lspconfig').gopls.setup({ on_attach = on_attach })
require('lspconfig').hls.setup({ on_attach = on_attach })

require('lualine').setup({
  options = { icons_enabled = true },
  sections = { lualine_c = { 'lsp_progress' } }
})
