# home/eren/chromium.nix
{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;

    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--enable-features=VaapiVideoDecoder"
      "--enable-gpu-rasterization"
      "--ignore-gpu-blocklist"
    ];
  };
}
