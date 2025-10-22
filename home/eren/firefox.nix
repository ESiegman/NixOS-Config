# home/eren/firefox.nix
{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    package = pkgs.firefox;

    profiles.default = {
      isDefault = true;

      settings = {
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        "gfx.webrender.all" = true;
      };

      userChrome = ''
        #TabsToolbar {
          visibility: collapse !important;
        }
        #tabbrowser-tabs:not([style*="--proton-tab-count: 1;"]) ~ #TabsToolbar {
          visibility: visible !important;
        }
      '';
    };
  };
}
