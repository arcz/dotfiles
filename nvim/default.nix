{ pkgs }:

pkgs.neovim.override {
  configure = {
    customRC = import ./vimrc.nix;

    packages.myVimPackage = with pkgs.vimPlugins; {
      # loaded on launch
      start = [
        nvim-lspconfig
        vim-colorschemes
        airline
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
