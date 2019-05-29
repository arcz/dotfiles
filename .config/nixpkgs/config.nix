{
  allowUnfree = true;

  packageOverrides = pkgs:
    let my_plugins = import ./vim/plugins.nix { inherit (pkgs) vimUtils fetchFromGitHub; };
        my_vimrc   = import ./vim/vimrc.nix;
    in with pkgs; rec {

    arturTmux = import ./tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };

    arturVim = vim_configurable.customize {
      name = "vim";

      vimrcConfig.customRC = my_vimrc;

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
          #fzf-vim
          #my_plugins.vim-ripgrep
          deoplete-nvim
          vim-signify

          #LanguageClient-neovim
          LanguageClient-neovim
          syntastic
          bundler
          haskell-vim
          vim-elixir
          rust-vim
          vim-nix

          psc-ide-vim
          purescript-vim
        ];

      };
    };

    arturNeovim = neovim.override {
      configure = {
        customRC = my_vimrc;

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
            nerdtree-git-plugin
            fzf-vim
            #my_plugins.vim-ripgrep
            deoplete-nvim
            vim-signify

            LanguageClient-neovim
            syntastic
            bundler
            haskell-vim
            vim-elixir
            rust-vim
            vim-nix

            psc-ide-vim
            purescript-vim
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

        htop
        tree
        netcat
        socat

        fzf
      ];
    };

  };
}
