{ neovim, vimPlugins }:

neovim.override {
  configure = {
    customRC = import ./vimrc.nix;

    packages.myVimPackage = with vimPlugins; {
      # loaded on launch
      start = [
        nvim-lspconfig
        vim-colorschemes
        airline
        vim-airline-themes
        fugitive
        rhubarb # :Gbrowse
        sensible
        vim-dispatch
        surround
        repeat
        ctrlp
        vim-vinegar
        fzf-vim
        vim-signify
        nvim-treesitter

        syntastic
        haskell-vim
        vim-elixir
        rust-vim
        vim-nix
        swift-vim
        NeoSolarized
        kotlin-vim
        vim-solidity
      ];
    };
  };
}
