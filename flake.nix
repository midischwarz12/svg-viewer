{
  description = "Small browser-based SVG viewer with timer refresh";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
      pkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
          runtimePath = pkgs.lib.makeBinPath (
            [
              pkgs.coreutils
            ]
            ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
              pkgs.xdg-utils
            ]
          );
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "svg-viewer";
            version = "0.1.0";
            src = self;

            dontBuild = true;
            nativeBuildInputs = [
              pkgs.makeWrapper
            ];

            installPhase = ''
              runHook preInstall
              install -Dm755 bin/svg-viewer "$out/bin/svg-viewer"
              wrapProgram "$out/bin/svg-viewer" --prefix PATH : ${runtimePath}
              runHook postInstall
            '';

            meta = {
              description = "Open an SVG in a browser and refresh it on a timer";
              homepage = "https://github.com/midischwarz12/svg-viewer";
              license = pkgs.lib.licenses.agpl3Only;
              mainProgram = "svg-viewer";
              platforms = systems;
            };
          };
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/svg-viewer";
          meta.description = "Open an SVG in a browser and refresh it on a timer";
        };
      });

      devShells = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.shellcheck
              pkgs.shfmt
              pkgs.jujutsu
            ];
          };
        }
      );
    };
}
