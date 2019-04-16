set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader = " "
let g:ruby_path='/usr/bin/ruby'

" set the runtime path to include Vundle and initialize
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin('~/.nvim/bundle')

Plugin 'gmarik/Vundle.vim'

Plugin 'flazz/vim-colorschemes'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-repeat'

Plugin 'vim-ruby/vim-ruby'
Plugin 'elixir-lang/vim-elixir'
Plugin 'lambdatoast/elm.vim'
Plugin 'idris-hackers/idris-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'purescript-contrib/purescript-vim'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'LnL7/vim-nix'
Plugin 'tomlion/vim-solidity'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'rking/ag.vim'
Plugin 'airblade/vim-gitgutter'
nnoremap <leader>a :Ag -i<space>

call vundle#end()            " required
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
