{
  description = "Dotfiles for my Linux setup, powered by Tack and Nix";
  outputs =
    { self, ... }@args:
    let
      inputs = (import ./.tack) { };
      inherit (import ./lib.nix { inherit inputs; })
        forSupportedSystems
        unstablePkgsFor
        mkHome
        mkDevShell
        treefmt
        ;
    in
    {
      homeConfigurations = {
        laptop = mkHome "x86_64-linux" ./hosts/laptop.nix;
        pc = mkHome "x86_64-linux" ./hosts/pc.nix;
        wsl = mkHome "x86_64-linux" ./hosts/wsl.nix;
      };

      devShells = forSupportedSystems (
        system:
        let
          pkgs = unstablePkgsFor system;
        in
        {
          default = mkDevShell pkgs;
        }
      );

      formatter = forSupportedSystems (
        system:
        let
          pkgs = unstablePkgsFor system;
        in
        (treefmt pkgs).config.build.wrapper
      );

      checks = forSupportedSystems (
        system:
        let
          pkgs = unstablePkgsFor system;
        in
        {
          formatting = (treefmt pkgs).config.build.check self;
        }
      );

    };
}
