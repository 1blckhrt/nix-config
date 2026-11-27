{ inputs }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  inherit (nixpkgs) lib;

  username = "blckhrt";

  forSupportedSystems = lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
  ];

  nixpkgsConfig = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  pkgsFor =
    system:
    nixpkgs.legacyPackages.${system} or (import nixpkgs {
      inherit system;
      config = nixpkgsConfig;
    });

  unstablePkgsFor =
    system:
    nixpkgs-unstable.legacyPackages.${system} or (import nixpkgs-unstable {
      inherit system;
      config = nixpkgsConfig;
    });

  mkHome =
    system: hostModule:
    let
      pkgs = pkgsFor system;
      unstablePkgs = unstablePkgsFor system;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs unstablePkgs;
      };
      modules = [
        {
          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "26.05";
        }
        hostModule
      ];
    };

  mkDevShell =
    pkgs:
    pkgs.mkShell {
      packages = builtins.attrValues {
        inherit (pkgs)
          convco
          just
          nixfmt
          statix
          nil
          rumdl
          shellcheck
          shfmt
          python3
          ruff
          ty
          ;
      };
    };

  treefmt = pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
in
{
  inherit
    forSupportedSystems
    pkgsFor
    unstablePkgsFor
    mkHome
    mkDevShell
    treefmt
    ;
}
