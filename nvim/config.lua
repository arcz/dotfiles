vim.g.mapleader = ' '

local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers)
vim.keymap.set('n', '<leader>fx', telescope_builtin.grep_string)
vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local bufopts = { noremap=true, silent=true, buffer=event.buf }

    vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gr',  telescope_builtin.lsp_references, bufopts)
    vim.keymap.set('n', 'ca',  vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gds', telescope_builtin.lsp_document_symbols, bufopts)
    vim.keymap.set('n', 'gws', telescope_builtin.lsp_workspace_symbols, bufopts)
    vim.keymap.set('n', 'cd',  vim.diagnostic.goto_next, bufopts)

    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "*",
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
    })

    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI", "InsertLeave"}, {
      pattern = "*",
      callback = function()
        vim.lsp.codelens.refresh()
      end,
    })
    vim.keymap.set("n", "cl", vim.lsp.codelens.run, bufopts)
  end
})

vim.lsp.config('rust_analyzer', {
  diagnostics = {
    enable = true,
    experimental = {
      enable = true,
    },
  },
})
vim.lsp.enable('ts_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('hls')
vim.lsp.enable('ccls')
vim.lsp.enable('nil_ls')
vim.lsp.enable('pyright')

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
