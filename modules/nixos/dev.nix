# modules/nixos/dev.nix
{ pkgs, inputs, ... }:
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
    doxygen
    tree-sitter
    arduino-cli

    (inputs.nix-shell-gen.packages.${pkgs.system}.default)
  ];

in {
  environment.systemPackages = languageToolchains ++ formattersAndLinters
    ++ generalDevUtils;

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];
}
