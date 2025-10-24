# modules/nixos/core.nix
{ pkgs, ... }:
{
  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
    networkmanager.applet.enable = true;
    firewall = {
      enable = true;
      #  allowedTCPPorts = [ 22 80 443 ];
      #  allowedUDPPorts = [ 53 ];
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  users.users.eren = {
    initialPassword = "password";
    isNormalUser = true;
    home = "/home/eren";
    description = "Primary User";
    openssh.authorizedKeys.keys = [
      # TODO: Add public key here
    ];
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "docker"
      "plugdev"
      "lp"
      "scanner"
      "input"
      "dialout"
      "docker"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}
