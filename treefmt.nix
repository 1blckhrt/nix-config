{ ... }:
let
  tackFiles = ".tack/**";
  envRC = ".envrc";
in
{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    statix.enable = true;
    rumdl-check.enable = true;
    rumdl-format.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
    stylua.enable = true;
    ruff-check.enable = true;
    ruff-format.enable = true;
  };
  settings.formatter = {
    nixfmt.excludes = [ tackFiles ];
    statix.excludes = [ tackFiles ];
    shfmt.excludes = [ envRC ];
    shellcheck.excludes = [ envRC ];
  };
}
