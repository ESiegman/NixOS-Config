# modules/system/default.nix
{ ... }: {
  imports = [ ./apps.nix ./common.nix ./core.nix ./stylix.nix ./dev.nix ];
}
