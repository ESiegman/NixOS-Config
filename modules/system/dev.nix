# modules/system/dev.nix
{
  pkgs,
  inputs,
  ...
}: let
  lsps = with pkgs; [
    nixd
    nil
    lua-language-server
    rust-analyzer
    bash-language-server
    pyright
    llvmPackages.clang-unwrapped
  ];

  formatters = with pkgs; [
    alejandra
    stylua
    shfmt
    rustfmt
    clang-tools
    prettierd
    nodePackages.prettier
    qt6.qtdeclarative
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
  environment.systemPackages = lsps ++ formatters ++ coreDevUtils;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
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
  };

  documentation.dev.enable = true;
}
