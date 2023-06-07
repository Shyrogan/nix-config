{ inputs, lib, config, pkgs, ... }: {
  xsession.windowManager.i3 = {
    enable = true;
  };
}
