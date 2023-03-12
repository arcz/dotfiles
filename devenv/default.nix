{ pkgs }:
with pkgs; pkgs.buildEnv{
  name = "devenv-artur";
  paths = [
    (callPackage (import ../nvim) { })
    (callPackage (import ../tmux) { })
    fish
    python3

    # Fish and nix-env compatibility
    # put 2 lines below in ~/.config/fish/config.fish
    # set fish_function_path $fish_function_path ~/.nix-profile/share/fish-foreign-env/functions
    # fenv source ~/.nix-profile/etc/profile.d/nix.sh
    fishPlugins.foreign-env

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
    ncdu_1 # ncdu/ncdu_2 is broken because zig is broken on macos
    curl
    wget
    file
    fzf
    ccls
  ];
}
