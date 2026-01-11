# hosts/desktop/default.nix
{ ... }: {
  imports = [ ./apps.nix ./core.nix ./hardware-configuration.nix ./rocm.nix ];
  networking.hostName = "desktop";
}
