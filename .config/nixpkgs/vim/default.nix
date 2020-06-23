let
  nixpkgs = import (builtins.fetchTarball {
    url = https://github.com/NixOS/nixpkgs/archive/926afba09cef87d201659f7433effb15a3382a94.tar.gz;
    sha256 = "1yp5r5pbpagwkxy65w0m0znmmijsf62asxgg7048v2nzd2zrislk";
  }) {};
in
{ pkgs ? nixpkgs }:

rec {
  neovim-5-dev = pkgs.neovim-unwrapped.overrideAttrs (attrs: {
    version = "v0.5.0-567-g4496628c1";
    src = pkgs.fetchFromGitHub {
     owner = "neovim";
     repo = "neovim";
     rev = "4496628c181e456d57e9257e14d8582d8dc548eb";
     sha256 = "0088ic9y1m86yskw877rfcldibbbcxhi9ygzfvsdiwvydbdymwgf";
    };
  });

  arturNeovim = (pkgs.wrapNeovim neovim-5-dev {}).override {
    configure = {
      customRC = import ./vimrc.nix;

      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          nvim-lsp
          vim-grepper
          vim-colorschemes
          airline
          fugitive
          rhubarb # :Gbrowse
          sensible
          vim-dispatch
          surround
          repeat
          ctrlp
          nerdtree
          nerdtree-git-plugin
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
        ];

      };
    };
  };
}
