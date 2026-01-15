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
      userContent = ''
        @-moz-document url("about:newtab"), url("about:home") {
          body {
            background-image: url("file://${
              ./../assets/images/firefox.jpg
            }") !important;
            background-size: cover !important;
            background-position: center !important;
            background-attachment: fixed !important;
            background-repeat: no-repeat !important;
          }

          .search-wrapper, .logo-and-wordmark {
            display: none !important;
          }

          .top-site-outer {
            background-color: rgba(24, 24, 37, 0.6) !important;
            border-radius: 8px !important;
            backdrop-filter: blur(4px);
          }
        }
      '';
    };
  };
  stylix.targets.firefox.profileNames = [ "default" ];
}
