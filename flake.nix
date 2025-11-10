{
  description = "NixOS & Standalone Nix configurations for 1blckhrt";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixvim,
    nixGL,
    pre-commit-hooks,
    ...
  }: let
    lib = import ./lib {inherit self nixpkgs inputs;};
    inherit (lib) mkHome mkSystem forAllSystems;
  in {
    homeConfigurations = {
      "blckhrt@laptop" = mkHome "x86_64-linux" [./hosts/laptop/home.nix];
      "blckhrt@pc" = mkHome "x86_64-linux" [./hosts/pc/home.nix];
      "blckhrt@wsl" = mkHome "x86_64-linux" [./hosts/wsl/home.nix];
    };

    nixosConfigurations = {
      "nixos" = mkSystem "x86_64-linux" [./hosts/nixos/configuration.nix];
    };

    checks = forAllSystems ({pkgs, ...}: {
      pre-commit-check = pre-commit-hooks.lib.${pkgs.system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          convco.enable = true;
        };
      };
    });

    devShells = forAllSystems ({
      pkgs,
      check,
      ...
    }: {
      default = pkgs.mkShell {
        inherit (check) shellHook;
        buildInputs =
          check.enabledPackages
          ++ [
            pkgs.alejandra
            pkgs.convco
          ];
      };
    });

    formatter = forAllSystems ({pkgs, ...}: pkgs.alejandra);
  };
}
