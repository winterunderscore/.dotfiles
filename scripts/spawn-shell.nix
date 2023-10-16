{ writeShellScriptBin }:
writeShellScriptBin "spawn-shell" ''
  if [[ "$#" -gt 1 ]]; then
    extras="''${@:2}"
    nix-shell-wrapper ~/.dotfiles/shells/"''$1".nix --arg extras "with import <nixpkgs> {}; [ ''$extras ]"
  else
    nix-shell-wrapper ~/.dotfiles/shells/"''$1".nix
  fi
''
