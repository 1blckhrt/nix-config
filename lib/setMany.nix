{nixpkgs, ...}: attrs: keys:
builtins.listToAttrs (builtins.map (name: nixpkgs.lib.nameValuePair name attrs) keys)
