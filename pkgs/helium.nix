# credit: https://github.com/fpletz/flake/blob/main/pkgs/by-name/helium-browser.nix
{
  stdenv,
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
}: let
  pname = "helium-browser";
  version = "0.8.4.1";
  architectures = {
    "x86_64-linux" = {
      arch = "x86_64";
      hash = "sha256-y4KzR+pkBUuyVU+ALrzdY0n2rnTB7lTN2ZmVSzag5vE=";
    };
  };
  src = let
    inherit (architectures.${stdenv.hostPlatform.system}) arch hash;
  in
    fetchurl {
      url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-${arch}.AppImage";
      inherit hash;
    };

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = "Helium Browser";
    exec = pname;
    icon = pname;
    comment = "Private, fast, and honest web browser";
    categories = ["Network" "WebBrowser"];
    terminal = false;
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs = pkgs:
      with pkgs; [
        freetype
        fontconfig
        liberation_ttf
        dejavu_fonts
      ];

    extraInstallCommands = ''
      mkdir -p $out/share/applications
      cp ${desktopItem}/share/applications/*.desktop $out/share/applications/
    '';

    meta = {
      description = "Private, fast, and honest web browser";
      homepage = "https://github.com/imputnet/helium-linux";
      platforms = lib.attrNames architectures;
    };
  }
