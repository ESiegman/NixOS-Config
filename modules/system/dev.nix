# modules/system/dev.nix
{ pkgs, inputs, ... }:
let
  lspsAndLinters = with pkgs; [
    # LSPs
    nixd
    nil
    lua-language-server
    rust-analyzer
    bash-language-server
    pyright
    llvmPackages.clang-unwrapped

    alejandra
    stylua
    shfmt
    rustfmt
    clang-tools
    prettierd
    nodePackages.prettier
  ];

  coreDevUtils = with pkgs; [
    git
    gnumake
    gcc
    cargo
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
