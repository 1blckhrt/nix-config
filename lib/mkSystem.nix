{
  self,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  nixvim,
  nixGL,
  ...
}: system: modules:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit self nixpkgs nixpkgs-unstable home-manager nixvim nixGL;
  };
  modules =
    if builtins.isList modules
    then modules
    else [modules];
}
