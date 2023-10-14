{ writeShellScriptBin }:
writeShellScriptBin "tmux-sessionizer" ''
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
''
