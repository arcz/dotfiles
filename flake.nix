{
  description = "Software tailored to Artur's taste";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.nvim = import ./nvim {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    };
    packages.x86_64-darwin.nvim = import ./nvim {
      pkgs = nixpkgs.legacyPackages.x86_64-darwin;
    };

    packages.x86_64-linux.tmux =
      nixpkgs.legacyPackages.x86_64-linux.callPackage (import ./tmux) { };
    packages.x86_64-darwin.tmux =
      nixpkgs.legacyPackages.x86_64-darwin.callPackage (import ./tmux) { };

    packages.x86_64-darwin.devenv =
      nixpkgs.legacyPackages.x86_64-darwin.callPackage (import ./devenv) { };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.devenv;
    defaultPackage.x86_64-darwin = self.packages.x86_64-darwin.devenv;

  };
}
