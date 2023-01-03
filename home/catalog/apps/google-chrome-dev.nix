{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = [
      pkgs.google-chrome-dev
    ];
    persistence = {
      "/persist/home/gogsaan" = {
        allowOther = true;
        directories = [".config/google-chrome-dev"];
      };
    };
  };

  # xdg.desktopEntries.vivaldi = {
  #   name = "Vivaldi";
  #   exec = "vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland";
  # };
}
