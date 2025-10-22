# modules/nixos/default.nix
{ ... }:
{
  #imports = lib.recursiveImport ./.;
  imports = [
    ./core.nix
    ./apps.nix
    ./desktop.nix
    ./dev.nix
    ./theme.nix
  ];
}
