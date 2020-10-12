let
  # TODO lock to avoid breaking fish patching etc.
  pkgs = import <nixpkgs> {};
  vim = import ./.config/nixpkgs/vim { inherit pkgs; };
in rec {
  fish-customconfig = pkgs.fish.overrideAttrs (attrs: {
    # a hack to sneak in extra config with customizable path
    patches = attrs.patches ++ [./.config/nixpkgs/fish/custom_config.patch];
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
