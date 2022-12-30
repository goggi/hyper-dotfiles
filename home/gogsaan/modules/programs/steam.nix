{
  pkgs,
  lib,
  ...
}: let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
  };
in {
  home.packages = with pkgs; [
    steam-with-pkgs
    protontricks
  ];
  home.persistence = {
    "/persist/games/gogsaan" = {
      allowOther = true;
      directories = [
        ".local/share/Paradox Interactive"
        ".paradoxlauncher"
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];
    };
  };
}
