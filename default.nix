let
  pkgs = import (builtins.fetchTarball {
    name = "nixos-unstable-2021-07-21";
    url = "https://github.com/nixos/nixpkgs/archive/314f595ab1cd09a27ad66dd1283344fa5745e473.tar.gz";
    sha256 = "sha256:11a8r0609yz3q3jslxwz1gff9n5sbzwhfx6cfbq1hhdlsxkcxjdv";
  }) {};
  vim = import ./.config/nixpkgs/vim { inherit pkgs; };
in rec {
  fish-customconfig = pkgs.fish.overrideAttrs (attrs: {
    # a hack to sneak in extra config with customizable path
    #patches = [./.config/nixpkgs/fish/custom_config.patch];
  });
  neovim-5-dev = vim.neovim-5-dev;
  neovim-artur = vim.neovim-artur;
  fish-artur = import ./.config/nixpkgs/fish {
    inherit (pkgs) writeText symlinkJoin makeWrapper;
    fish = fish-customconfig;
  };
  tmux-artur = import ./.config/nixpkgs/tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };
  devenv-artur = import ./.config/nixpkgs/devenv { inherit pkgs neovim-artur tmux-artur fish-artur; };
}
