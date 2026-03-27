{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    zsh
  ];

  home.file.".zshrc" = {
    text = ''
      source ~/nix-config/dotfiles/zsh/zsh.zsh
    '';
    executable = true;
  };

  programs.zsh.profileExtra = ''
    rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
    rm -rf ${config.home.homeDirectory}/.icons/nix-icons
    ls ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop > ${config.home.homeDirectory}/.cache/current_desktop_files.txt
  '';
}
