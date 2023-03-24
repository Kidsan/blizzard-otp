{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {

      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShellNoCC {
          packages = with pkgs.${system}; [
            (python311.withPackages (ps: with ps; [
              (
                buildPythonPackage rec {
                  pname = "bna";
                  version = "5.1.0";
                  src = fetchPypi
                    {
                      inherit pname version;
                      sha256 = "sha256-9sU1J7yP41hT9JYrZ8gFbZi1rba6bP1xNQa8F1u7Z6c=";
                    };
                  doCheck = false;
                  nativeBuildInputs = [
                    ps.click
                    ps.pyotp
                  ];
                }
              )
              qrcode
              setuptools
              ps.pyotp
              ps.click
            ]))
          ];
        };
      });
    };
}
