{
  description = "NixOS & Standalone Nix configurations for 1blckhrt";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixGL.url = "github:nix-community/nixGL";
    hooks.url = "github:cachix/git-hooks.nix";
    colors.url = "github:misterio77/nix-colors";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    hooks,
    colors,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    mkHome = host:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/${host}/home.nix
          {
            home = {
              username = "blckhrt";
              homeDirectory = "/home/blckhrt";
              stateVersion = "25.11";
            };
          }
        ];
      };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "old";
            extraSpecialArgs = {inherit inputs;};
            users.blckhrt = {
              imports = [./hosts/nixos/home.nix inputs.nixvim.homeModules.nixvim];
            };
          };
        }
      ];
    };
    homeConfigurations = {
      laptop = mkHome "laptop";
      wsl = mkHome "wsl";
      pc = mkHome "pc";
    };
    devShells.${system}.default = let
      check = hooks.lib.${system}.run {
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
    in
      pkgs.mkShell {
        inherit (check) shellHook;
        buildInputs = check.enabledPackages;
      };
    formatter.${system} = pkgs.alejandra;
  };
}
