{
  allowUnfree = true;

  packageOverrides = pkgs:
    let my_plugins = import ./vim/plugins.nix { inherit (pkgs) vimUtils fetchFromGitHub; };
        my_vimrc   = import ./vim/vimrc.nix;
    in with pkgs; rec {

    arturTmux = import ./tmux { inherit (pkgs) tmux writeText symlinkJoin makeWrapper; };

    neovim-unwrapped = pkgs.neovim-unwrapped.overrideAttrs (attrs: {
      version = "v0.5.0-567-g4496628c1";
      src = fetchFromGitHub {
       owner = "neovim";
       repo = "neovim";
       rev = "4496628c181e456d57e9257e14d8582d8dc548eb";
       sha256 = "0088ic9y1m86yskw877rfcldibbbcxhi9ygzfvsdiwvydbdymwgf";
      };
    });

    arturNeovim = neovim.override {
      configure = {
        customRC = my_vimrc;

        packages.myVimPackage = with pkgs.vimPlugins; {
          # loaded on launch
          start = [
            nvim-lsp
            vim-grepper
            vim-colorschemes
            airline
            fugitive
            rhubarb # :Gbrowse
            sensible
            vim-dispatch
            surround
            repeat
            ctrlp
            nerdtree
            nerdtree-git-plugin
            fzf-vim
            vim-signify

            syntastic
            bundler
            haskell-vim
            vim-elixir
            rust-vim
            vim-nix
            swift-vim
            NeoSolarized
            kotlin-vim
          ];

        };
      };
    };

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
