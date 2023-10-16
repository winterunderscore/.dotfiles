{
  pkgs ? import <nixpkgs> {},
  extras ? "",
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    rustup
    rustc
    cargo
    extras
  ];
}
