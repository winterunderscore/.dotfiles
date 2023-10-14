{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    gh

    # MISC
    hello
    vim
    
    just
    eza
    bat
    fzf
    hyperfine

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    
    (callPackage ../scripts/tmux-sessionizer.nix {})
    (callPackage ../scripts/spawn-shell.nix {})
  ];
}
