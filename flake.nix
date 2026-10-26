{
  description = "Dotfiles for my Linux setup, powered by Tack and Nix";
  outputs =
    { self, ... }@args:
    let
      inputs = (import ./.tack) { };
      lib = import ./lib { inherit inputs; };
    in
    {
      homeConfigurations = {
        laptop = lib.mkHome {
          modules = [ ./hosts/laptop.nix ];
        };

        pc = lib.mkHome {
          modules = [ ./hosts/pc.nix ];
        };
      };

      devShells = lib.forAllUnstableSystems (pkgs: {
        default = lib.mkDevShell pkgs;
      });

      formatter = lib.forAllUnstableSystems (pkgs: (lib.treefmt pkgs).config.build.wrapper);

      checks = lib.forAllUnstableSystems (pkgs: {
        formatting = (lib.treefmt pkgs).config.build.check self;
      });
    };
}
