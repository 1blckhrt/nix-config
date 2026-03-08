{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hooks.url = "github:cachix/git-hooks.nix";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    hooks,
    nix-colors,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    homeConfigurations = {
      mint-laptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/laptop/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };

      pc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./hosts/pc/home.nix];
        extraSpecialArgs = {inherit inputs;};
      };
    };

    devShells.${system}.default = let
      check = hooks.lib.${system}.run {
        src = ./.;
        package = pkgs.prek;
        hooks = {
          statix.enable = true;
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
