{ writeShellScriptBin }:
writeShellScriptBin "nix-shell-wrapper" ''
  nix-shell --run fish $@
''
