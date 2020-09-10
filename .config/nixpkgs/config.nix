{
  allowUnfree = true;

  packageOverrides = pkgs:
    let vim = import ./vim { pkgs = pkgs; };
        my_plugins = import ./vim/plugins.nix { inherit (pkgs) vimUtils fetchFromGitHub; };
    in with pkgs; rec {

    fish = pkgs.fish.overrideAttrs (attrs: {
      # a hack to sneak in extra config with customizable path
      patches = attrs.patches ++ [./fish/custom_config.patch];
    });

    arturFish = import ./fish { inherit fish; inherit (pkgs) writeText symlinkJoin makeWrapper; };

    arturTmux = import ./tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };

    neovim-unwrapped = vim.neovim-5-dev;

    arturNeovim = vim.arturNeovim;

    arturDev = pkgs.buildEnv {
      name = "artur-dev";
      paths = [
        arturNeovim
        arturTmux
        arturFish
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

        htop
        tree
        netcat
        socat

        fzf
      ];
    };

  };
}
