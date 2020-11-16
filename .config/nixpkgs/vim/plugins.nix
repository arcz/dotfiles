{ vimUtils, fetchFromGitHub }:
{
  neuron-vim = vimUtils.buildVimPluginFrom2Nix {
    name = "neuron-vim-1.0-dev";
    patches = [./plugins/neuron.patch];
    src = fetchFromGitHub {
      owner = "fiatjaf";
      repo = "neuron.vim";
      rev = "3015bbb2eb2ec1d64885faa31007c9e499af2598";
      sha256 = "1w9c3b8j4dpz6qwsah9p9p5siqm357fq7jiksawwgzgdcjd2sjkj";
    };
  };
}
