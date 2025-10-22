# flake.nix
{
  description = "Modular NixOS configuration for an AMD GPU Desktop";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

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

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-grub-theme = {
      url = "github:jeslie0/nixos-grub-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          inputs.sddm-sugar-candy-nix.overlays.default
        ];
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
          permittedInsecurePackages = [
            "freeimage-unstable-2021-11-01"
          ];
        };
      };
      specArgs = {
        inherit inputs;
        inherit pkgs;
      };
    in
    {
      pkgs.${system} = pkgs;

      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = specArgs;
        modules = [
          home-manager.nixosModules.home-manager
          ./hardware-configuration.nix
          ./hosts/desktop/default.nix
          ./modules/nixos/default.nix
          inputs.stylix.nixosModules.stylix
          inputs.sddm-sugar-candy-nix.nixosModules.default
          inputs.spicetify-nix.nixosModules.spicetify
         {
            home-manager.backupFileExtension = "bak";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specArgs;
            home-manager.users.eren = ./home/eren/default.nix;
         }
        ];
      };
    };
}
