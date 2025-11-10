{
  nixpkgs,
  inputs,
  self,
  ...
}: {
  forAllSystems = import ./forAllSystems.nix {inherit nixpkgs self;};
  mkSystem = import ./mkSystem.nix {
    inherit self nixpkgs;
    inherit (inputs) nixpkgs-unstable home-manager nixvim nixGL;
  };
  mkHome = import ./mkHome.nix {
    inherit self nixpkgs;
    inherit (inputs) nixpkgs-unstable home-manager nixvim nixGL;
  };
}
