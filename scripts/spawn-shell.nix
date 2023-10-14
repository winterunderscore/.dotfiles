{ writeShellScriptBin }:
writeShellScriptBin "spawn-shell" ''
  #!/usr/bin/env bash
  if [[ "$#" -gt 1 ]]; then
    extras="''${@:2}"
    nix-shell ~/.dotfiles/shells/"''$1".nix --arg extras "with import <nixpkgs> {}; [ ''$extras ]"
  else
    nix-shell ~/.dotfiles/shells/"''$1".nix
  fi
''
