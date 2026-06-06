#!/usr/bin/env bash

nix run home-manager/release-26.05 -- switch --flake ~/nix-config#pc
