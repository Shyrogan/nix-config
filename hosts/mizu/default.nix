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


  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.getty.autologinUser = "shyrogan";
  services.xserver = {
    enable = true;

    layout = "fr";
    xkbVariant = "";

    videoDrivers = [ "amdgpu" ];
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
    };
  };
  # Locales, keyboard
  console.keyMap = "fr";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.05";
}
