function ghcenv --description 'start a nix-shell with the given haskell packages'
  if set -q argv[1]
    set argv $argv[1..-1]
  end

  for el in $argv
    set hpkgs $hpkgs "p.$el"
  end

  nix-shell -p "haskellPackages.ghcWithPackages (p: [$hpkgs])"
end
