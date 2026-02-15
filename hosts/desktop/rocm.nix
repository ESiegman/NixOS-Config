# hosts/desktop/rocm.nix
{pkgs, ...}: {
  hardware = {
    graphics = {
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        rocmPackages.clr
        rocmPackages.rocminfo
        libva-utils
      ];
    };
    amdgpu.overdrive.enable = true;
  };

  environment = {
    variables = {
      ROC_ENABLE_PRE_VEGA = "1";
      HIP_PLATFORM = "amd";
    };
    systemPackages = with pkgs; [radeontop amdgpu_top];
  };

  systemd = {
    tmpfiles.rules = ["L+    /opt/rocm   -    -    -     -    ${pkgs.rocmPackages.clr}"];
    packages = [pkgs.lact];
    services.lactd.wantedBy = ["multi-user.target"];
  };
}
