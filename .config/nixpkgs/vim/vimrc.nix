let
  languageServerConfig =
    ''
    " --- LanguageClient-neovim config ---
    let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
    let g:LanguageClient_loggingLevel = 'INFO'
    let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'
    let g:LanguageClient_rootMarkers = {
      \ 'haskell': ['stack.yaml'],
      \ 'purescript': ['psc-package.json']
    \ }
    let g:LanguageClient_serverCommands = {
      \ 'haskell': ['hie-wrapper', '--lsp', '--vomit', '-r', getcwd()],
      \ 'purescript': ['purescript-language-server', '--stdio']
    \ }

    nnoremap <F5> :call LanguageClient_contextMenu()<CR>
    map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
    map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
    map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
    map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
    map <Leader>lb :call LanguageClient#textDocument_references()<CR>
    map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
    map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
    '';
in
  ''
  set encoding=utf-8
  set nocompatible              " be iMproved, required
  filetype off                  " required
  let mapleader = " "
  set shell=/bin/sh
  setlocal wrap
  set colorcolumn=80

  nnoremap <leader>a :GrepperRg<space>

  filetype plugin indent on    " required

  colorscheme molokai

  syntax on
  set number
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

  ${languageServerConfig}

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:psc_ide_syntastic_mode = 0
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  "let g:psc_ide_server_runner=["yarn", "--silent", "purs"]

  autocmd filetype purescript setlocal omnifunc=LanguageClient#complete

  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  ''
