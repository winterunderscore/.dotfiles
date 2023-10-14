[private]
_default:
    @just --list

[linux]
hm type:
    home-manager {{type}} --flake "./hm"
