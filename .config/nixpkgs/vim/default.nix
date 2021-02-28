{ pkgs }:

let plugins = pkgs.callPackage (import ./plugins.nix) {};
in
rec {
  neovim-5-dev = pkgs.neovim-unwrapped.overrideAttrs (attrs: {
    version = "v0.5.0-dev+1115-gc1fbc2ddf";
    src = pkgs.fetchFromGitHub {
     owner = "neovim";
     repo = "neovim";
     rev = "c1fbc2ddf15b2f44b615f90b2511349ab974cb83";
     sha256 = "0kvk3r4by8r3asmfl69iw93xnd8lwfr0pynynlhr5y8h5pjd3rfi";
    };
    buildInputs = attrs.buildInputs ++ [ pkgs.tree-sitter ];
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
          neuron-vim
        ];

      };
    };
  };
}
