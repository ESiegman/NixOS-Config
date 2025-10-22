# hosts/desktop/defaults.nix
{ ... }:
{
  # imports = lib.recursiveImport ./.;
  imports = [ ./hardware.nix ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
