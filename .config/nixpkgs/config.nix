{
  allowUnfree = true;

  packageOverrides = pkgs:
    let vim = import ./vim { pkgs = pkgs; };
        my_plugins = import ./vim/plugins.nix { inherit (pkgs) vimUtils fetchFromGitHub; };
    in with pkgs; rec {

    arturTmux = import ./tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };

    neovim-unwrapped = vim.neovim-5-dev;

    arturNeovim = vim.arturNeovim;

    arturDev = pkgs.buildEnv {
      name = "artur-dev";
      paths = [
        arturNeovim
        arturTmux
        #arturFish

        fish
        git
        jq
        pgcli
        ripgrep
        tig

        htop
        tree
        netcat
        socat

        fzf
      ];
    };

  };
}
