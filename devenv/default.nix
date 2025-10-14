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
    pgcli
    ripgrep
    tig
    bat
    watch
    rsync
    hextazy

    lsof
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
    pyright

    nil # Nix LSP
  ];
}
