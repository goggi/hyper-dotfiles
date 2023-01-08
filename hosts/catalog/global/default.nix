# This file (and the global directory) holds config that i use on all hosts
{
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./sops.nix
    ./ssh.nix
  ];
}
