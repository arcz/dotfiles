{ vimUtils, fetchFromGitHub }:
{
  vim-ripgrep = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-ripgrep-2018-09-09";
    src = fetchFromGitHub {
      owner = "jremmen";
      repo = "vim-ripgrep";
      rev = "ec87af6b69387abb3c4449ce8c4040d2d00d745e";
      sha256 = "1by56rflr0bmnjvcvaa9r228zyrmxwfkzkclxvdfscm7l7n7jnmh";
    };
    dependencies = [];
  };
}
