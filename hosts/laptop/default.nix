# hosts/laptop/default.nix
{ ... }: {
  imports = [
    #./hardware-configuration.nix 
    ./core.nix
    ./nvidia.nix
    ./apps.nix
    ../../modules/system/core.nix
    ../../modules/system/common.nix
    ../../modules/system/apps.nix
    ../../modules/system/dev.nix
  ];

  networking.hostName = "laptop";
}
