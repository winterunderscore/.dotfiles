{
  pkgs ? import <nixpkgs> {},
  extras ? "",
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    clang
    gnumake
    ninja
    extras
  ];
}
