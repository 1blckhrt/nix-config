{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    obsidian = {
      enable = true;
      settings = {
        workspaces = [
          {
            name = "main";
            path = "~/Documents/Notes/";
          }
        ];
      };
    };
  };
}
