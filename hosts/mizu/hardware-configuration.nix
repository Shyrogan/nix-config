{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/300721d2-ca49-490d-b95e-be98c6752869";
    fsType = "ext4";
  };

  fileSystems."/boot"= {
    device = "/dev/disk/by-uuid/F349-BF07";
    fsType = "vfat";
  };
  
  swapDevices = [
    { device = "/dev/disk/by-uuid/7b710c2d-c241-4f03-b7f7-1ff99f48be05"; }
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
