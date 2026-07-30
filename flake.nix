{
  description = "My Home Manager configuration";

  nixConfig = {
    extra-substituters = [ "https://vicinae.cachix.org" ];
    extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae.url = "github:vicinaehq/vicinae";
    mnw.url = "github:Gerg-L/mnw";
    hooks.url = "github:cachix/git-hooks.nix";
    helium-browser.url = "github:oxcl/nix-flake-helium-browser";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      mnw,
      hooks,
      vicinae,
      helium-browser,
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
            mnw.homeManagerModules.mnw
            vicinae.homeManagerModules.default
            helium-browser.homeModules.default
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
