{
  description = "Simple haskell nix flake";

  nixConfig.bash-prompt = "[nix]\\e\[38;5;172mλ \\e\[m";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };



  outputs = { flake-utils, nixpkgs, self }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        config = {};
        overlays = [];
        pkgs = import nixpkgs { inherit config overlays system; };
        myGhc = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs; [
          vector
        ]);
      in rec {
        devShell = pkgs.haskellPackages.shellFor {
          packages = p: [
            myGhc
          ];

          buildInputs = with pkgs.haskellPackages; [
            cabal-install

            # Helpful tools for `nix develop` shells
            #
            ghcid                   # https://github.com/ndmitchell/ghcid
            haskell-language-server # https://github.com/haskell/haskell-language-server
            hlint                   # https://github.com/ndmitchell/hlint
            ormolu                  # https://github.com/tweag/ormolu
          ];

          withHoogle = true;
        };
      }
    );
}
