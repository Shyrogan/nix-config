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

  packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; });

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.getty.autologinUser = "shyrogan";
  # Locales, keyboard
  console.keyMap = "fr";
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.05";
}
