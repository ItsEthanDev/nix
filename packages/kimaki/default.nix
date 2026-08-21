{
  fetchgit,
  fetchPnpmDeps,
  lib,
  makeWrapper,
  nodejs_22,
  pnpm_10,
  pnpmConfigHook,
  stdenv,
}: let
  lockfilePatch = ''
    substituteInPlace pnpm-lock.yaml \
      --replace-fail \
      "packageExtensionsChecksum: 12a00ea3a37f088c14786963e400c96c" \
      "packageExtensionsChecksum: sha256-/VTHs9J0RGLH2lU39U6Ra5aj1bwTgDrArdwh46iKBWY="
  '';
in
  stdenv.mkDerivation (finalAttrs: {
    pname = "kimaki";
    version = "0.23.1";

    src = fetchgit {
      url = "https://github.com/remorses/kimaki.git";
      rev = "7dc3e74ff309df39f93aa20da344344621b3ffc3";
      hash = "sha256-klgq1ZXxONdgRRhFSazO78CV6ys7KJA1AnN7i9V4CDc=";
      fetchSubmodules = true;
    };

    postPatch = lockfilePatch;

    pnpmDeps = fetchPnpmDeps {
      inherit (finalAttrs) pname version src;
      hash = "sha256-QqShao72D5506+nAeNBD940twaoISorbfxGwfeg13Ts=";
      fetcherVersion = 3;
      pnpm = pnpm_10;
      postPatch = lockfilePatch;
    };

    nativeBuildInputs = [
      makeWrapper
      nodejs_22
      pnpm_10
      pnpmConfigHook
    ];

    buildPhase = ''
        runHook preBuild
      pnpm run prepare
      rm -rf cli/dist
      pnpm --filter kimaki generate
      pnpm --filter kimaki exec tsc --noCheck
      cp -r skills cli/skills
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      install -d "$out/lib/kimaki"
      cp -a ./. "$out/lib/kimaki"

      makeWrapper ${nodejs_22}/bin/node "$out/bin/kimaki" --add-flags "$out/lib/kimaki/cli/bin.js"
      runHook postInstall
    '';

    meta = {
      description = "Collaborative OpenCode agent orchestrator for Discord";
      homepage = "https://github.com/remorses/kimaki";
      license = lib.licenses.mit;
      mainProgram = "kimaki";
      platforms = lib.platforms.linux;
    };
  })
