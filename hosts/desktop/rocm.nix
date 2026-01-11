# hosts/desktop/rocm.nix
{ pkgs, ... }: {

  hardware.graphics = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
      rocmPackages.rocminfo
      libva-utils
    ];
  };

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
    HIP_PLATFORM = "amd";
  };

  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm   -    -    -     -    ${pkgs.rocmPackages.clr}" ];

  environment.systemPackages = with pkgs; [ radeontop amdgpu_top ];
}
