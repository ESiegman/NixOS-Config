# hosts/laptop/default.nix
{ ... }: {
  imports = [
    ./hardware-configuration.nix 
    ./core.nix
    ./nvidia.nix
    ./apps.nix
  ];

  networking.hostName = "laptop";
}
