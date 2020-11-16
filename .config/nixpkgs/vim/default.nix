{ pkgs }:

let plugins = pkgs.callPackage (import ./plugins.nix) {};
in
rec {
  neovim-5-dev = pkgs.neovim-unwrapped.overrideAttrs (attrs: {
    version = "v0.5.0-627-g94b7ff730";
    src = pkgs.fetchFromGitHub {
     owner = "neovim";
     repo = "neovim";
     rev = "94b7ff730a1914c14f347f5dc75175dc34a4b3f5";
     sha256 = "15fpihn2xbdzp4nb1sgni0wyr94q89y45jaxfmzh6vjbx8f76m0w";
    };
  });

  neovim-artur = (pkgs.wrapNeovim neovim-5-dev {}).override {
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
          plugins.neuron-vim
        ];

      };
    };
  };
}
