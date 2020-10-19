{ neovim-artur, tmux-artur, fish-artur, pkgs }:
with pkgs;
pkgs.buildEnv {
  name = "devenv-artur";
  paths = [
    neovim-artur
    tmux-artur
    fish-artur
    python3

    # Fish and nix-env compatibility
    # put 2 lines below in ~/.config/fish/config.fish
    # set fish_function_path $fish_function_path ~/.nix-profile/share/fish-foreign-env/functions
    # fenv source ~/.nix-profile/etc/profile.d/nix.sh
    fish-foreign-env

    git
    jq
    pgcli
    ripgrep
    tig
    bat

    htop
    tree
    netcat
    socat
    ncdu
    curl
    wget
    file
    fzf
  ];
}
