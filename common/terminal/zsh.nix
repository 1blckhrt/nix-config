{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh
  ];

  home.file.".zshrc" = {
    text = ''
      source ~/nix-config/dotfiles/zsh/zsh.zsh
    '';
    executable = true;
  };
}
