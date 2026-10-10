{ inputs, nixpkgsFor }:

{
  system ? "x86_64-linux",
  username ? "blckhrt",
  homeDirectory ? "/home/${username}",
  modules ? [ ],
  ...
}:

inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = nixpkgsFor system;
  extraSpecialArgs = {
    inherit inputs;
  };
  modules = [
    {
      home.username = username;
      home.homeDirectory = homeDirectory;
      home.stateVersion = "26.05";
    }
    inputs.mnw.homeManagerModules.mnw
  ]
  ++ modules;
}
