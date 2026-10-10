{ inputs, ... }:

let
  nixpkgsConfig = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];

  nixpkgsFor =
    system:
    import inputs.nixpkgs {
      inherit system;
      config = nixpkgsConfig;
    };

  unstableNixpkgsFor =
    system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config = nixpkgsConfig;
    };
in
{
  inherit systems nixpkgsFor;

  eachSystem = f: inputs.nixpkgs.lib.genAttrs systems (system: f (nixpkgsFor system));

  treefmtEval = system: inputs.treefmt-nix.lib.evalModule (unstableNixpkgsFor system) ../treefmt.nix;

  mkDevShell = pkgs: import ./devshell.nix { inherit pkgs; };

  mkHome = import ./home.nix { inherit inputs nixpkgsFor; };
}
