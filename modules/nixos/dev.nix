# modules/nixos/dev.nix
{ pkgs, ... }:
let
  languageToolchains = with pkgs; [
    # C / C++
    gcc
    gdb
    clang
    cmake
    pkg-config

    # Python
    python313
    python313Packages.pip

    # Wev Dev
    nodejs
    jre
    typescript
    bun
    go_1_24

    # Nix
    nil
    nixd

    # Other
    lua-language-server
    texlive.combined.scheme-full
    cargo
    rust-analyzer
  ];

  formattersAndLinters = with pkgs; [
    # C / C++

    # Python
    black
    isort

    # Web
    prettierd

    # Nix
    nixpkgs-fmt

    # Other
    stylua
    shfmt
    rustfmt
  ];

  generalDevUtils = with pkgs; [
    git
    gnumake
    screen
    usbutils
  ];

in
{
  environment.systemPackages = languageToolchains ++ formattersAndLinters ++ generalDevUtils;
}
