{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.05"; # Please read the comment before changing.

    # The packages option allows you to install Nix packages into your
    # environment.
    packages = [
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

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
