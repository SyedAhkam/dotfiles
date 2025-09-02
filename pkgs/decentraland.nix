{
  lib,
  stdenv,
  pkgs,
}:
let
  archive =
    {
      aarch64-darwin = {
        name = "Decentraland_installer.dmg";
        hash = "sha256-t6ccFd51KD1uIlz1jkqlTleArvxzwensTJrTpdJCiPs=";
      };
    }.${stdenv.targetPlatform.system} or (throw "${stdenv.targetPlatform.system} is unsupported.");
in
stdenv.mkDerivation (finalAttrs: {
  pname = "decentraland";
  version = "latest";

  sourceRoot = ".";

  src = pkgs.fetchurl {
    url = "https://explorer-artifacts.decentraland.org/launcher-rust/${archive.name}";
    inherit (archive) hash;
  };

  buildInputs = [  ];

  nativeBuildInputs = [
    pkgs.undmg
  ];

  installPhase = ''
    mkdir -p $out/Applications/
    cp -a Decentraland.app $out/Applications/
  '';

  meta = {
    description = "";
    homepage = "https://decentraland.org";
    changelog = "";
    license = with lib.licenses; [
      mit
      unfree
    ];
    maintainers = with lib.maintainers; [
      syedahkam
    ];
    mainProgram = "decentraland";
    platforms = lib.platforms.darwin;
  };
})