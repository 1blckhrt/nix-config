# Detect current hostname
HOSTNAME := $(shell hostname)

# Default system type (override with make <target> system=<arch>)
SYSTEM ?= x86_64-linux

# ===== Home Manager configs =====
.PHONY: home
home:
ifeq ($(HOSTNAME),pc)
	home-manager switch --flake .#blckhrt@$(HOSTNAME) --impure
else
	home-manager switch --flake .#blckhrt@$(HOSTNAME)
endif

# ===== Maintenance =====

.PHONY: update
update:
	nix flake update

.PHONY: gc
gc:
	nix-collect-garbage -d

