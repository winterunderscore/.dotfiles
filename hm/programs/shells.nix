{...}: 

let
  shellAliases = {
    ts = "tmux-sessionizer";
    ss = "spawn-shell";
    cat = "bat";
    test = "echo yay";
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
