{ pkgs, ... }:

pkgs.mkShell {
  packages = [
    pkgs.git
    pkgs.convco
    pkgs.just
  ];
  shellHook = "echo 'Dev shell ready'";
}
