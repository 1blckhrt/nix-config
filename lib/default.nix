{ inputs }:
let
  inherit (inputs.nixpkgs) lib;

  supportedSystems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  nixpkgsConfig = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  stablePkgsFor =
    system:
    import inputs.nixpkgs {
      inherit system;
      config = nixpkgsConfig;
    };

  unstablePkgsFor =
    system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config = nixpkgsConfig;
    };
in
{
  forAllSystems = f: lib.genAttrs supportedSystems (system: f (stablePkgsFor system));
  forAllUnstableSystems = f: lib.genAttrs supportedSystems (system: f (unstablePkgsFor system));

  mkHome = import ./mkHome.nix { inherit inputs stablePkgsFor unstablePkgsFor; };
  mkDevShell = pkgs: import ./mkDevShell.nix { inherit pkgs inputs; };
}
