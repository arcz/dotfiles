{ fish, writeText, symlinkJoin, makeWrapper }:
symlinkJoin {
  name = "fish";
  buildInputs = [makeWrapper];
  paths = [ fish ];
  postBuild = ''
    wrapProgram "$out/bin/fish" \
    --prefix FISH_CUSTOM_CONFIG_DIR : ${./config}
    '';
}
