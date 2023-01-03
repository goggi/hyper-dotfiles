{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  # use OCR and copy to clipboard
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../../../../../catalog/desktops/common/wayland
    ../../dunst
    ../../gtk.nix
    ../../rofi.nix
    ../../swaylock.nix
  ];

  home = {
    packages = with pkgs; [
      ocrScript
      pngquant
      python39Packages.requests
      tesseract5
      xorg.xprop
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ];
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default.override {};
    systemdIntegration = true;
    extraConfig = import ./config.nix;
  };
}
