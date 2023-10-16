{...}: 

let
  shellAliases = {
    ts = "tmux-sessionizer";
    ss = "spawn-shell";
    cat = "bat";
  };
in {
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = shellAliases;
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
