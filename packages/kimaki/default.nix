{
  fetchgit,
  fetchPnpmDeps,
  lib,
  makeWrapper,
  nodejs_22,
  pnpm_9,
  pnpmConfigHook,
  stdenv,
}: let
  pnpm = pnpm_9.overrideAttrs (old: {
    meta = old.meta // {knownVulnerabilities = [];};
  });
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

    pnpmDeps = fetchPnpmDeps {
      inherit (finalAttrs) pname version src;
      hash = "sha256-F61RmkawJftmj5EO7/4DP0ppTAGkOgQR7xXVAtu+p1w=";
      fetcherVersion = 3;
      inherit pnpm;
    };

    nativeBuildInputs = [
      makeWrapper
      nodejs_22
      pnpm
      pnpmConfigHook
    ];

    buildPhase = ''
      runHook preBuild
      pnpm run prepare
      rm -rf cli/dist
      pnpm --filter kimaki generate
      pnpm --filter kimaki exec tsc --noCheck
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
