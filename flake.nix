# flake.nix
{
  description =
    "Modular NixOS configuration for an AMD GPU Desktop and NVIDIA GPU Laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-shell-gen.url = "github:esiegman/nix-shell-gen";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      user = "eren";

      mkSystem = { hostname, extraModules ? [ ] }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs user; };
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            ./hosts/${hostname}/default.nix

            ./modules/system/default.nix

            inputs.stylix.nixosModules.stylix
            inputs.spicetify-nix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs user; };
                backupFileExtension = "bak";
                sharedModules =
                  [ inputs.plasma-manager.homeModules.plasma-manager ];
                users.${user} = import ./modules/home/default.nix;
              };
            }
            {
              nixpkgs.config.permittedInsecurePackages =
                [ "freeimage-unstable-2021-11-01" ];
            }
          ] ++ extraModules;
        };

    in {
      nixosConfigurations = {
        desktop = mkSystem {
          hostname = "desktop";
          extraModules = [ ];
        };

        laptop = mkSystem {
          hostname = "laptop";
          extraModules = [
            inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
            inputs.nixos-hardware.nixosModules.common-cpu-intel
          ];
        };
      };
    };
}
