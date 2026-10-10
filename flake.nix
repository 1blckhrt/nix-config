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

      formatter = lib.eachSystem (pkgs: (lib.treefmtEval pkgs.system).config.build.wrapper);

      checks = lib.eachSystem (pkgs: {
        formatting = (lib.treefmtEval pkgs.system).config.build.check self;
      });

      devShells = lib.eachSystem (pkgs: {
        default = lib.mkDevShell pkgs;
      });
    };
}
