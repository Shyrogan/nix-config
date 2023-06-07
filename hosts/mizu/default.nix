{ pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common/users/shyrogan.nix
  ];
  
  networking = {
    hostName = "mizu";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader.systemd-boot.enable = true;
  };

  programs = {
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.getty.autologinUser = "shyrogan";

  system.stateVersion = "23.05";
}
