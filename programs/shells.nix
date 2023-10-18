{pkgs, ...}: 

let
  shellAliases = {
    ts = "tmux-sessionizer";
    ss = "spawn-shell";
    cat = "bat";
    nix-shell = "nix-shell-wrapper";
  };
in {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = shellAliases;
    };
    fish = {
      enable = true;
      shellAliases = shellAliases;
      plugins = [
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "8d99f0caa30a626369541f80848ffdbf28e96acc";
            sha256 = "sha256-nTiFD8vWjafYE4HNemyoUr+4SgsqN3lIJlNX6IGk+aQ=";
          };
        } 
        {
          name = "z";
          src = pkgs.fetchFromGitHub {
            owner = "jethrokuan";
            repo = "z";
            rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
            sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
          };
        }
      ];
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      settings = {
        command_timeout = 5000;
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
        };
        directory = {
          fish_style_pwd_dir_length = 2;
          truncate_to_repo = false;
        };
      };
    };
  };
}
