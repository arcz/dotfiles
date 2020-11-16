{ neovim-artur, tmux-artur, fish-artur, pkgs }:
with pkgs;
let neuron-notes =
  (let neuronRev = "15e482e5e0a876fb3fe42936d9992e91d5f0c98a";
       neuronSrc = builtins.fetchTarball "https://github.com/srid/neuron/archive/${neuronRev}.tar.gz";
    in import neuronSrc {});
in pkgs.buildEnv {
  name = "devenv-artur";
  paths = [
    neovim-artur
    tmux-artur
    fish-artur
    neuron-notes
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
