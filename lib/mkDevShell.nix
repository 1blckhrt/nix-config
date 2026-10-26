{ pkgs, ... }:

pkgs.mkShell {
  packages = builtins.attrValues {
    inherit (pkgs)
      git
      convco
      just
      nixfmt
      statix
      nil
      rumdl
      shellcheck
      shfmt
      stylua
      ruff
      ty
      ;
  };
  shellHook = "echo 'Dev shell ready'";
}
