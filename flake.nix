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
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    commit = {
      url = "github:1blckhrt/commit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixvim,
    pre-commit-hooks,
    commit,
    nixgl,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    forAllSystems = lib.genAttrs [system];
  in {
    # ===== Standalone home-manager configurations =====
    homeConfigurations = {
      "blckhrt@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inputs = {
            inherit
              self
              nixpkgs
              nixpkgs-unstable
              home-manager
              nixvim
              commit
              nixgl
              ;
          };
          nixgl = nixgl.packages.${system};
        };
        modules = [
          ./hosts/laptop/home.nix
          {
            home.packages = [
              commit.packages.${system}.default
            ];
          }
        ];
      };
      "blckhrt@pc" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inputs = {
            inherit
              self
              nixpkgs
              nixpkgs-unstable
              home-manager
              nixvim
              commit
              nixgl
              ;
          };
          nixgl = nixgl.packages.${system};
        };
        modules = [
          ./hosts/pc/home.nix
          {
            home.packages = [
              commit.packages.${system}.default
            ];
          }
        ];
      };
      "blckhrt@wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inputs = {
            inherit self nixpkgs home-manager nixvim commit;
          };
        };
        modules = [
          ./hosts/wsl/home.nix
          {
            home.packages = [
              commit.packages.${system}.default
            ];
          }
        ];
      };
    };
    # ===== Git hooks / formatting / linting =====
    checks = forAllSystems (system: {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          convco.enable = true;
        };
      };
    });
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      check = self.checks.${system}.pre-commit-check;
    in {
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
    formatter =
      forAllSystems (system:
        nixpkgs.legacyPackages.${system}.alejandra);
  };
}
