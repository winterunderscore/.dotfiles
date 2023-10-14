[private]
_default:
    @just --list

[linux]
hm type *args:
    home-manager {{type}} --flake "./hm"
