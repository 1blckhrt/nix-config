# Detect current hostname
HOSTNAME := $(shell hostname)

# Default system type (override with make <target> system=<arch>)
SYSTEM ?= x86_64-linux

# ===== Home Manager configs =====

.PHONY: home
home:
	home-manager switch --flake .#blckhrt@$(HOSTNAME)

# ===== System Manager configs =====

.PHONY: system
system:
	@if grep -q '^ID=nixos' /etc/os-release; then \
		echo "⚠️  system-manager setup skipped: detected NixOS."; \
	else \
		sudo env "PATH=$$HOME/.nix-profile/bin:$$PATH" \
		nix run --extra-experimental-features 'flakes nix-command' 'github:numtide/system-manager' \
			-- switch \
			--flake .#$(HOSTNAME) ; \
	fi
	@echo "✅ System setup done."

# ===== Maintenance =====

.PHONY: update
update:
	nix flake update

.PHONY: gc
gc:
	nix-collect-garbage -d
