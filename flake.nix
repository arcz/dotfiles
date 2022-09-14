{
  description = "Software tailored to Artur's taste";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages.nvim = pkgs.callPackage (import ./nvim) { };
        packages.tmux = pkgs.callPackage (import ./tmux) { };
        packages.devenv = pkgs.callPackage (import ./devenv) { };
        packages.default = packages.devenv;
      }
    );
}
