{
  description = "NixOS configuration for 1blckhrt";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    system-manager,
    nix-system-graphics,
    ...
  } @ inputs: let
    system = "x86_64-linux";
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
          ./hosts/pc-mint/system.nix
          nix-system-graphics.systemModules.default
        ];
      };
    };

    # ===== Standalone home-manager configurations =====
    homeConfigurations = {
      "blckhrt@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          # make the flake inputs available inside the home-manager modules
          inputs = {inherit self nixpkgs home-manager system-manager nixvim nix-system-graphics;};
        };
        modules = [
          ./hosts/laptop/home.nix
          {home.packages = [system-manager.packages.x86_64-linux.default];}
        ];
      };

      "blckhrt@pc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inputs = {inherit self nixpkgs home-manager system-manager nixvim nix-system-graphics;};
        };
        modules = [
          ./hosts/pc-mint/home.nix
          {home.packages = [system-manager.packages.x86_64-linux.default];}
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

              users = {
                blckhrt = {
                  imports = [./hosts/rustbucket/home/home.nix];
                };
              };
            };
          }
        ];
      };
    };
  };
}
