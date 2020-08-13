let
  languageclient = ''
    lua vim.cmd('packadd nvim-lsp')
    "lua require'nvim_lsp'.rls.setup{}
    lua require'nvim_lsp'.rust_analyzer.setup{}
    lua require'nvim_lsp'.ccls.setup{}
    lua require'nvim_lsp'.tsserver.setup{}
    lua require'nvim_lsp'.gopls.setup{}

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> gtd   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    '';
in
  ''
  set encoding=utf-8
  "set nocompatible              " be iMproved, required
  "filetype off                  " required
  let mapleader = " "
  set shell=/bin/sh
  setlocal wrap
  set colorcolumn=80,100

  nnoremap <leader>a :Rg<space>

  filetype plugin indent on    " required

  syntax enable
  "set background=dark
  let g:solarized_termcolors=256
  colorscheme gruvbox

  syntax on
  "set number
  set relativenumber

  set history=500 " keep 500 lines of command line history
  set ruler " show the cursor position all the time
  set showcmd " display incomplete commands
  set list
  set listchars=trail:·,tab:»·
  set backupdir=~/.vim/backup
  set directory=~/.vim/backup
  set nobackup
  set hidden
  "set spell
  "set spelllang=en_us

  set ts=2
  set sts=2
  set sw=2
  set expandtab

  set laststatus=2

  " Enable file type detection
  filetype on

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType haskell setlocal ts=8 sts=4 sw=4 expandtab shiftround

  " Remove trailing whitespaces
  autocmd BufWritePre * :%s/\s\+$//e

  nmap <leader>n :NERDTree<cr>
  let NERDTreeShowHidden=1

  imap jj <Esc>
  map <leader>h <C-w>h
  map <leader>j <C-w>j
  map <leader>k <C-w>k
  map <leader>l <C-w>l

  noremap <Leader>s :update<CR>

  " Reselect visual block after indent/outdent
  vnoremap < <gv
  vnoremap > >gv

  " exclude .gitignored files
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

  let g:haskell_classic_highlighting = 0
  let g:haskell_indent_disable = 1
  let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
  let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
  let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
  let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
  let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
  let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
  let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

  autocmd filetype purescript setlocal omnifunc=LanguageClient#complete

  " Use deoplete.
  let g:deoplete#enable_at_startup = 1

  " disable preview window
  set completeopt-=preview

  " use omni completion provided by lsp
  set omnifunc=lsp#omnifunc

  set termguicolors
  let g:neosolarized_contrast = "high"

  ${languageclient}
  ''
