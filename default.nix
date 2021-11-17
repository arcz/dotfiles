let
  pkgs = import (builtins.fetchTarball {
    name = "nixos-unstable-2021-11-03";
    url = "https://github.com/nixos/nixpkgs/archive/4789953e5c1ef6d10e3ff437e5b7ab8eed526942.tar.gz";
    sha256 = "sha256:15nksgi9pncz59l8vrfg05g9dqw835wwdi9bmghffyg0k1yh2j8d";
  }) {};
  vim = import ./.config/nixpkgs/vim { inherit pkgs; };
in rec {
  neovim-artur = vim.neovim-artur;
  tmux-artur = import ./.config/nixpkgs/tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };
  devenv-artur = import ./.config/nixpkgs/devenv { inherit pkgs neovim-artur tmux-artur; };
}
