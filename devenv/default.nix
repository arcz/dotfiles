{ pkgs }:
with pkgs; pkgs.buildEnv {
  name = "devenv-artur";
  paths = [
    (callPackage (import ../nvim) { })
    (callPackage (import ../tmux) { })
    fish
    python3

    git
    jq
    # pgcli # broken
    ripgrep
    tig
    bat
    watch
    rsync

    htop
    tree
    netcat
    socat
    ncdu
    curl
    wget
    file
    fzf
    ccls

    nil # Nix LSP
  ];
}
