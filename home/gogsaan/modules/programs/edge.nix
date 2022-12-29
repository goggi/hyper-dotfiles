{pkgs, ...}: {
  programs.microsoft-edge = {
    enable = true;
    package = pkgs.microsoft-edge.override {
      commandLineArgs = ''
        --enable-features=UseOzonePlatform \
        --ozone-platform=wayland
      '';
    };
  };
}
