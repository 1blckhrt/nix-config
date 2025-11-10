{pkgs, ...}:
with pkgs; {
  commit = callPackage ./commit.nix {};
}
