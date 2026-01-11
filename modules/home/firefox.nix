# home/eren/firefox.nix
{ pkgs, ... }: {
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

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "svg.context-properties.content.enabled" = true;
      };

      userChrome = builtins.readFile ./../native/firefox/userChrome.css;
    };
  };
  stylix.targets.firefox.profileNames = [ "default" ];
}
