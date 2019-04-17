{
  allowUnfree = true;

  packageOverrides = pkgs:
      let my_plugins = import ./vim/plugins.nix { inherit (pkgs) vimUtils fetchFromGitHub; };
      in with pkgs; rec {

      arturTmux = import ./tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };

      arturVim = vim_configurable.customize {
        name = "vim";

        vimrcConfig.customRC = ''
          set encoding=utf-8
          set nocompatible              " be iMproved, required
          filetype off                  " required
          let mapleader = " "

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
          '';

        vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
          # loaded on launch
          start = [
            vim-grepper
            vim-colorschemes
            airline
            fugitive
            sensible
            #vim-endwise
            vim-dispatch
            surround
            repeat
            ctrlp
            nerdtree
            #my_plugins.vim-ripgrep

            bundler
            haskell-vim
            purescript-vim
            vim-elixir
            rust-vim
            vim-nix
          ];

        };
      };

      arturNeovim = neovim.override {
        configure = {
          customRC = ''
            set encoding=utf-8
            set nocompatible              " be iMproved, required
            filetype off                  " required
            let mapleader = " "

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
            '';

        packages.myVimPackage = with pkgs.vimPlugins; {
          # loaded on launch
          start = [
            vim-grepper
            vim-colorschemes
            airline
            fugitive
            sensible
            #vim-endwise
            vim-dispatch
            surround
            repeat
            ctrlp
            nerdtree
            #my_plugins.vim-ripgrep

            bundler
            haskell-vim
            purescript-vim
            vim-elixir
            rust-vim
            vim-nix
          ];

        };
      };
      };

      arturDev = pkgs.buildEnv {
        name = "artur-dev";
        paths = [
          arturVim
          arturNeovim
          arturTmux

          fish
          git
          jq
          pgcli
          ripgrep
          tig
        ];
      };

    };
}
