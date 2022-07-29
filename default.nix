let
  pkgs = import (builtins.fetchTarball {
    name = "nixos-unstable-2022-01-08";
    url = "https://github.com/nixos/nixpkgs/archive/32356ce11b8cc5cc421b68138ae8c730cc8ad4a2.tar.gz";
    sha256 = "sha256:0kfw7ir745yp3ixhcz8vfs7nf94w9jx2c3xrhjy94b2g5bl0wyk8";
  }) {};
  vim = import ./.config/nixpkgs/vim { inherit pkgs; };
in rec {
  neovim-artur = vim.neovim-artur;
  tmux-artur = import ./.config/nixpkgs/tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };
  devenv-artur = import ./.config/nixpkgs/devenv { inherit pkgs neovim-artur tmux-artur; };
}
