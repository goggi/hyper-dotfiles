{
  pkgs,
  config,
  lib,
  outputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  services.geoclue2.enable = true;
  users.mutableUsers = true;
  users.users.gogsaan = {
    description = "Gogsaan";
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPassword = "$6$ao4GNMyGjn0Z2URn$TvSlCHgpf40AKMNiG7aUnxsNVA8ljjLyC1fdd1chwAsx3/4ZnApmf9dG5.xSsMcrX2FmcoiKq5RkxTg2UIM.L0";
    extraGroups =
      [
        "i2c"
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "nix"
        "systemd-journal"
      ]
      ++ ifTheyExist [
        "docker"
        "git"
        "libvirtd"
        "mysql"
      ];

    openssh.authorizedKeys.keys = [];
  };
}
