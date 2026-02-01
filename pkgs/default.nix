{pkgs, ...}:
with pkgs; {
  commit = callPackage ./commit.nix {};
  helium = callPackage ./helium.nix {};
}
