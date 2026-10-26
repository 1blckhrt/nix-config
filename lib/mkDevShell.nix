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
      python3
      ;
  };
  shellHook = ''
    python3 ${../scripts/last_update.py}
  '';
}
