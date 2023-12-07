{ pkgs ? import <nixpkgs> {} }:
let myGhc = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
      vector 
      split
    ]);
in
pkgs.mkShell {
  buildInputs = [ myGhc ];
}

