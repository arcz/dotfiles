function pyenv --description 'start a nix-shell with the given python packages' --argument pythonVersion
  if set -q argv[2]
    set argv $argv[2..-1]
  end

  set ppkgs $ppkgs "python"$pythonVersion"Packages.ipython"

  for el in $argv
    set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
  end

  nix-shell -p $ppkgs
end

# Invocation: pyenv package1 package2 .. packageN
# or:         pyenv 2 ..
