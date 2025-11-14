{config, ...}: {
  home.file."Pictures/Wallpapers" = {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-config/common/temp-hypr/swaybg/conf";
    recursive = true;
  };
}
