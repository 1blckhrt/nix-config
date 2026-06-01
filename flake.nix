{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix.url = "github:nix-community/stylix/release-25.11";
    # TODO: uncomment after 26.05 is released

    mnw.url = "github:Gerg-L/mnw";
    hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      # stylix,
      mnw,
      hooks,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
        };
      };
    in
    {
      homeConfigurations = {
        pc = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            # stylix.homeModules.stylix
            mnw.homeManagerModules.mnw
            ./hosts/pc/home.nix
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
      devShells.${system}.default =
        let
          check = hooks.lib.${system}.run {
            src = ./.;
            package = pkgs.prek;
            hooks = {
              statix.enable = true;
              nixfmt.enable = true;
              stylua.enable = true;
              convco.enable = true;
            };
          };
        in
        pkgs.mkShell {
          inherit (check) shellHook;
          buildInputs = check.enabledPackages;
        };
      formatter.${system} = pkgs.nixfmt;
    };
}
