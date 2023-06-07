{ inputs, outputs, ... }:
{
  imports = [
    ./global.nix
    ./features/desktop/i3.nix
  ];
}
