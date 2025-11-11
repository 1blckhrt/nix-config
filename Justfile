HOSTNAME := `hostname`

# Home Manager
home:
    home-manager switch --flake .#blckhrt@{{HOSTNAME}}

# NixOS rebuild
os:
    sudo nixos-rebuild switch --flake .#{{HOSTNAME}}

# Update flake
update:
    nix flake update

# Garbage collection
gc:
    nix-collect-garbage -d
