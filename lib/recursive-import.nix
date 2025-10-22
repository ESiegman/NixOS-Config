# lib/recursive-imports.nix
{ lib }:
path:
let
  blacklist = [
    "default.nix"
    "flake.nix"
    "recusive-import.nix"
  ];

  getNixFilePaths =
    directory:
    lib.flatten (
      lib.mapAttrsToList (
        name: type:
        let
          fullPath = builtins.toPath "${directory}/{${name}";
        in
        if type == "directory" then
          getNixFilePaths fullPath
        else if lib.strings.hasSuffix ".nix" name && !(builtins.elem name blacklist) then
          [ fullPath ]
        else
          [ ]
      ) (builtins.readDir directory)
    );
in
getNixFilePaths path
