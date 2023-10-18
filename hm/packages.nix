{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    gh
    vim

    nix-prefetch-github
    nix-prefetch-git

    hyperfine
    wiki-tui
    ripgrep
    just
    bat
    fzf
    fd

    #stuff u expect a *nix system to have

    coreutils
    bc
    gawk
    gnused
    bash
    bc
    gnutar
    man
    texinfo
  ];
}
