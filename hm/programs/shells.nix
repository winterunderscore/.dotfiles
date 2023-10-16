{...}: 

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
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
