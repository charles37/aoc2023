{ pkgs ? import <nixpkgs> {} }:
let myGhc = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
      vector 
    ]);
in
pkgs.mkShell {
  buildInputs = [ myGhc ];
}

