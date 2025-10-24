# Detect current hostname
HOSTNAME := $(shell hostname)

# Default system type (override with make <target> system=<arch>)
SYSTEM ?= x86_64-linux

# ===== Home Manager configs =====

.PHONY: home
home:
	home-manager switch --flake .#blckhrt@$(HOSTNAME)

# ===== Maintenance =====

.PHONY: update
update:
	nix flake update

.PHONY: gc
gc:
	nix-collect-garbage -d
