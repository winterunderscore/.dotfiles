{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    (callPackage ./tmux-sessionizer.nix {})
    (callPackage ./nix-shell-wrapper.nix {})
    (callPackage ./spawn-shell.nix {})
  ];
}
