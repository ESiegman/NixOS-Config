{ pkgs, inputs, ... }:
let
  lspsAndLinters = with pkgs; [
    nixd
    nil
    lua-language-server
    rust-analyzer
    bash-language-server
    pyright

    alejandra
    stylua
    shfmt
    black
    prettierd
  ];

  coreDevUtils = with pkgs; [
    git
    gnumake
    gcc
    tree-sitter
    (inputs.nix-shell-gen.packages.${pkgs.system}.default)
  ];

in {
  environment.systemPackages = lspsAndLinters ++ coreDevUtils;

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
    libxml2
    glibc
  ];

  documentation.dev.enable = true;
}
