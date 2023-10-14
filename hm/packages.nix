{pkgs, ...}: {
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.gh

    # MISC
    pkgs.hello
    pkgs.vim
    
    pkgs.just
    pkgs.eza
    pkgs.bat
    pkgs.fzf
    pkgs.hyperfine

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    (pkgs.writeShellScriptBin "tmux-sessionizer" ''
      if [[ $# -eq 1 ]]; then
          selected=$1
      else
          selected=$(find ~/ ~/personal ./ -mindepth 1 -maxdepth 1 -type d | fzf)
      fi

      if [[ -z $selected ]]; then
          exit 0
      fi

      selected=$(realpath $selected)
      session_name=$(basename "$selected" | tr . _)

      not_in_tmux() {
        [ -z "$TMUX" ]
      }

      session_exists() {
        tmux has-session -t "=$session_name" 2> /dev/null
      }

      create_detached_session() {
        (TMUX="" tmux new-session -Ad -s "$session_name" -c $selected)
      }

      create_if_needed_and_attach() {
        if not_in_tmux; then
          tmux new-session -As "$session_name" -c $selected
        else
          if ! session_exists; then
            create_detached_session
          fi
          tmux switch-client -t "$session_name"
        fi
      }

      create_if_needed_and_attach
    '')
    (pkgs.writeShellScriptBin "spawn-shell" ''
      #!/usr/bin/env bash
      if [[ "$#" -gt 1 ]]; then
        extras="''${@:2}"
        nix-shell ~/.dotfiles/shells/"''$1".nix --arg extras "with import <nixpkgs> {}; [ ''$extras ]"
      else
        nix-shell ~/.dotfiles/shells/"''$1".nix
      fi
    '')
  ];
}
