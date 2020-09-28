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

    fish-artur = import ./fish { inherit fish; inherit (pkgs) writeText symlinkJoin makeWrapper; };

    tmux-artur = import ./tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };

    neovim-unwrapped = vim.neovim-5-dev;

    neovim-artur = vim.neovim-artur;

    devenv-artur = pkgs.buildEnv {
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

        fzf
      ];
    };

  };
}
