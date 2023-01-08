{
  pkgs,
  config,
  lib,
  outputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # Yubikey
  services.udev.extraRules = ''
    # Yubikey 4/5 U2F+CCID
    SUBSYSTEM=="usb", ATTR{idVendor}=="1050", ATTR{idProduct}=="0406", ENV{ID_SECURITY_TOKEN}="1", GROUP="wheel"
  '';
  services.udev.packages = [pkgs.yubikey-personalization];
  programs.gnupg.agent = {
    enable = true;
  };
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  security.pam.yubico = {
    enable = true;
    debug = true;
    mode = "challenge-response";
  };
  services.pcscd.enable = true;

  services.geoclue2.enable = true;
  users.mutableUsers = true;
  users.users.gogsaan = {
    description = "Gogsaan";
    isNormalUser = true;
    shell = pkgs.zsh;
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
    sopsFile = ../../catalog/global/secrets.yaml;
    neededForUsers = true;
  };
}
