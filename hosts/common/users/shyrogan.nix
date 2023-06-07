{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  users.mutableUsers = false;
  users.users.shyrogan = {
    isNormalUser = true;
    password = "...";
    description="Sébastien VIAL";
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "network"
      "wireshark"
      "i2c"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
      "deluge"
    ];

    packages = [ pkgs.home-manager pkgs.git pkgs.vim ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Import your home-manager configuration
      shyrogan = import ../../../home/shyrogan/${config.networking.hostName}.nix;
    };
  };
}
