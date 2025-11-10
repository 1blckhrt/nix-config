home:
    if [ "$(hostname)" = "pc" ]; then \
        home-manager switch --flake .#blckhrt@$(hostname) --impure; \
    else \
        home-manager switch --flake .#blckhrt@$(hostname); \
    fi

os:
    sudo nixos-rebuild switch --flake .#nixos

update:
    nix flake update

gc:
    nix-collect-garbage -d

