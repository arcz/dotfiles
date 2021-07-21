{ pkgs }:

let plugins = pkgs.callPackage (import ./plugins.nix) {};
in
rec {
  neovim-artur = pkgs.neovim.override {
    configure = {
      customRC = import ./vimrc.nix;

      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          nvim-lspconfig
          #vim-grepper
          vim-colorschemes
          airline
          fugitive
          rhubarb # :Gbrowse
          sensible
          vim-dispatch
          surround
          repeat
          ctrlp
          #nerdtree
          #nerdtree-git-plugin
          vim-vinegar
          fzf-vim
          vim-signify

          syntastic
          haskell-vim
          vim-elixir
          rust-vim
          vim-nix
          swift-vim
          NeoSolarized
          kotlin-vim
          neuron-vim
          vim-solidity
        ];

      };
    };
  };
}
