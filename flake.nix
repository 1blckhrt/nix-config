{
  description = "NixOS configuration for 1blckhrt";

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

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
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
    system-manager,
    nix-system-graphics,
    pre-commit-hooks,
    commit,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    forAllSystems = lib.genAttrs [system];
  in {
    # ===== Non-NixOS systems (system-manager) =====
    systemConfigs = {
      laptop = system-manager.lib.makeSystemConfig {
        modules = [
          ./hosts/laptop/system.nix
          nix-system-graphics.systemModules.default
        ];
      };

      pc = system-manager.lib.makeSystemConfig {
        modules = [
          ./hosts/pc-arch/system.nix
          nix-system-graphics.systemModules.default
        ];
      };
    };

    # ===== Standalone home-manager configurations =====
    homeConfigurations = {
      "blckhrt@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inputs = {inherit self nixpkgs nixpkgs-unstable home-manager system-manager nixvim nix-system-graphics commit;};};
        modules = [
          ./hosts/laptop/home.nix
          {
            home.packages = [
              system-manager.packages.${system}.default
              commit.packages.${system}.default
            ];
          }
        ];
      };

      "blckhrt@pc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inputs = {inherit self nixpkgs nixpkgs-unstable home-manager system-manager nixvim nix-system-graphics commit;};};
        modules = [
          ./hosts/pc-arch/home.nix
          {
            home.packages = [
              system-manager.packages.${system}.default
              commit.packages.${system}.default
            ];
          }
        ];
      };

      "blckhrt@wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inputs = {inherit self nixpkgs home-manager nixvim commit;};};
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

    # ===== NixOS system configuration =====
    nixosConfigurations = {
      rustbucket = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};

        modules = [
          ./hosts/rustbucket/configuration.nix
          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};

              users.blckhrt.imports = [./hosts/rustbucket/home/home.nix];
            };

            # unstable tailscale, stable doesn't build
            environment.systemPackages = [
              (import nixpkgs-unstable {inherit system;}).tailscale
            ];
            services.tailscale.enable = true;
          }
        ];
      };
    };

    # ===== Git hooks / formatting / linting =====
    checks = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
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
        buildInputs = check.enabledPackages ++ [pkgs.alejandra pkgs.convco];
      };
    });

    formatter = forAllSystems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );
  };
}
