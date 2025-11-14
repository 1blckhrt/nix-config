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

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nixvim,
    nixGL,
    pre-commit-hooks,
    ...
  } @ inputs: rec {
    lib = nixpkgs.lib // home-manager.lib // (import ./lib {inherit nixpkgs self;});

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {tools = lib;};
        modules = [
          ./hosts/nixos/configuration.nix
          {
            system.stateVersion = "25.05";
          }
          inputs.home-manager.nixosModules.home-manager
          {
            users.users.blckhrt.isNormalUser = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "old";
              users.blckhrt = {
                home.stateVersion = "25.05";
                imports = [./hosts/nixos/home.nix inputs.nixvim.homeModules.nixvim];
              };
            };
          }
        ];
      };
    };

    standaloneHomeConfigurations = ["laptop" "wsl" "pc"];

    standaloneHomeManagers = lib.genAttrs standaloneHomeConfigurations (
      host:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
              allowUnfreePredicate = _: true;
            };
          };
          extraSpecialArgs = {
            inherit self nixpkgs nixpkgs-unstable home-manager nixvim nixGL;
          };
          modules = [./hosts/${host}/home.nix];
          homeDirectory = "/home/blckhrt";
          username = "blckhrt";
          stateVersion = "25.05"; # DO NOT TOUCH
          imports = [inputs.nixvim.homeModules.nixvim];
        }
    );

    checks = lib.forAllSystems ({system, ...}: {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          statix = {
            enable = true;
            settings.ignore = ["/.direnv" "hardware-configuration.nix"];
          };
          convco.enable = true;
          alejandra.enable = true;
        };
      };
    });

    devShells = lib.forAllSystems ({
      pkgs,
      check,
      ...
    }: {
      default = pkgs.mkShell {
        inherit (check) shellHook;
        buildInputs = check.enabledPackages;
      };
    });

    formatter = lib.forAllSystems ({pkgs, ...}: pkgs.alejandra);
  };
}
