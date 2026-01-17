# modules/system/core.nix
{
  pkgs,
  user,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["root" "@wheel"];
      warn-dirty = false;
      substituters = ["https://cache.nixos.org/"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  users.users.${user} = {
    initialPassword = "password";
    isNormalUser = true;
    home = "/home/eren";
    description = "Primary User";
    openssh.authorizedKeys.keys = [];
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "plugdev"
      "lp"
      "scanner"
      "input"
      "dialout"
      "docker"
      "render"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  networking = {
    networkmanager.enable = true;
    firewall = {enable = true;};
  };

  time = {timeZone = "America/New_York";};

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl."vm.swappiness" = 10;
  };

  environment = {
    variables.XDG_RUNTIME_DIR = "/run/user/1000";
  };

  system.stateVersion = "25.05";
}
