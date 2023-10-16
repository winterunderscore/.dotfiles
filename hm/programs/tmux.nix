{...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      set -g default-terminal 'screen-256color'

      unbind C-b
      set-option -g prefix C-a
      bind C-a send-prefix

      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key -r C-h select-window -t :-
      bind-key -r C-l select-window -t :+

      set -g base-index 1
      set-window-option -g pane-base-index 1
      set -g renumber-windows on

      set -g status-style bg='#666666',fg='#aaaaaa'
    '';
  };
}
