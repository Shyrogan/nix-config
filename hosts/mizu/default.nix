{ pkgs, inputs, ... }: {
  imports = [
    ../../common/users/shyrogan
  ];
  
  networking = {
    hostName = "mizu";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
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
    openrgb.enable = true;
  };

  services.getty.autologinUser = "shyrogan";

  system.stateVersion = "23.05";
}
