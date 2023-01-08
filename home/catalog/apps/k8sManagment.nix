{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = [
      pkgs.k9s
      pkgs.kubectl
    ];
  };
}
