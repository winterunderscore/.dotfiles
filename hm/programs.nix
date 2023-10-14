{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
      extraLuaConfig = ''
        local o = vim.opt
        o.nu = true
        o.rnu = true

        o.autoindent = true
        o.smartindent = true

        o.shiftwidth = 4
        o.tabstop = 4
        o.expandtab = true
        local indents = {
          ["haskell"] = 2,
          ["nix"] = 2,
          ["lua"] = 4,
          ["c"] = 8,
        }
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "*",
          callback = function() 
            local ft = vim.bo.filetype
            print(ft)
            o.shiftwidth = indents[ft] or 4
            o.tabstop = indents[ft] or 4
          end
        })
      '';
    };
    tmux = {
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

    git = {
      enable = true;
    };

    fish = {
      enable = true;
      shellAliases = {
        ts = "tmux-sessionizer";
        ss = "spawn-shell";
        cat = "bat";
        ls = "eza -a";
      };
    };
  };
}
