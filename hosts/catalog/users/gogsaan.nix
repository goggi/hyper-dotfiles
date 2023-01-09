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
    shell = pkgs.fish;
    passwordFile = config.sops.secrets.gogsaan-password.path;
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
  sops.secrets.gogsaan-password = {
    sopsFile = ../../catalog/secrets.yaml;
    neededForUsers = true;
  };

  programs = {
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["gogsaan"];
    };
  };
}
