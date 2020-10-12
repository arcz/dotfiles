{ fish, writeText, symlinkJoin, makeWrapper }:
symlinkJoin {
  name = "fish";
  buildInputs = [makeWrapper];
  paths = [ fish ];
  postBuild = ''
    wrapProgram "$out/bin/fish" \
    --set FISH_CUSTOM_CONFIG_DIR ${./config}
    '';
}
