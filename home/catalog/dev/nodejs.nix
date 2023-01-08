{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = [
      pkgs.nodejs
    ];
  };
}
