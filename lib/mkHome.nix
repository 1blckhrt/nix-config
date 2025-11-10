{
  self,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  nixvim,
  nixGL,
  ...
}: let
  mkPkgs = system:
    import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
    };
in
  system: modules:
    home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs system;
      extraSpecialArgs = {
        inherit self nixpkgs nixpkgs-unstable home-manager nixvim nixGL;
      };
      modules =
        if builtins.isList modules
        then modules
        else [modules];
    }
