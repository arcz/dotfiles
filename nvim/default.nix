{ neovim, vimPlugins }:

neovim.override {
  configure = {
    customRC = ''
      lua dofile('${./config.lua}')
      source ${./vimrc.viml}
    '';

    packages.myVimPackage = with vimPlugins; {
      # loaded on launch
      start = [
        nvim-lspconfig
        nvim-lsputils
        lualine-nvim
        lualine-lsp-progress
        vim-devicons
        telescope-nvim
        telescope-live-grep-args-nvim
        lsp-status-nvim

        fugitive
        rhubarb # :GBrowse
        sensible
        surround
        repeat
        vim-vinegar
        fzf-vim
        vim-signify

        haskell-vim # improves Haskell syntax highlighting
        vim-elixir
        rust-vim
        vim-nix
        swift-vim
        kotlin-vim
        vim-solidity

        vim-colorschemes
        gruvbox-community

        indent-blankline-nvim
        markdown-preview-nvim
        nvim-ufo
      ];
    };
  };
}
