{pkgs, ...}: let
  edgeDesktopItem = pkgs.makeDesktopItem {
    name = "Edge Wayland";
    desktopName = "Edge Wayland";
    exec = "microsoft-edge --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };
in {
  home.packages = [edgeDesktopItem];
}
