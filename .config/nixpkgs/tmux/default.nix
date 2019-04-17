# source: https://nmattia.com/posts/2018-03-21-nix-reproducible-setup-linux-macos.html
# Tmux with ./tmux.conf baked in
{ tmux, writeText, symlinkJoin, makeWrapper }:
symlinkJoin {
  name = "tmux";
  buildInputs = [makeWrapper];
  paths = [ tmux ];
  postBuild = ''
    wrapProgram "$out/bin/tmux" \
    --add-flags "-f ${./tmux.conf}"
    '';
}
