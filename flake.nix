{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    hooks,
    nixvim,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    homeConfigurations = {
      laptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/laptop/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };

      pc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/pc/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };

      debian-server = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/debian-server/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };
    };

    devShells.${system}.default = let
      check = hooks.lib.${system}.run {
        src = ./.;
        package = pkgs.prek;
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
