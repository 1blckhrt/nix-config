{
  nixpkgs,
  self,
  ...
}: {
  forAllSystems = import ./forAllSystems.nix {inherit nixpkgs self;};
  setMany = import ./setMany.nix {inherit nixpkgs;};
}
