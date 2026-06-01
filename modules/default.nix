{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./nh.nix
    ./nvim.nix
    #./theming.nix
    ./vesktop.nix
  ];

  home.packages = with pkgs; [
    ioskeley-mono.normal-NF
  ];
}
