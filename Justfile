# ===== Home Manager configs =====
home:
    if [ "$(hostname)" = "pc" ]; then \
        home-manager switch --flake .#blckhrt@$(hostname) --impure; \
    else \
        home-manager switch --flake .#blckhrt@$(hostname); \
    fi

# ===== Maintenance =====
update:
    nix flake update

gc:
    nix-collect-garbage -d

