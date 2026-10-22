{
  autoPatchelfHook,
  buildNpmPackage,
  fetchurl,
  lib,
  makeWrapper,
  nodejs,
  stdenv,
}: let
  releases = {
    aarch64-linux = {
      target = "aarch64-unknown-linux-gnu";
      hash = "sha256-yKOckqxlJB9YwlAR5BvjwRH8SNuww6q/oYkZFetM3/Q=";
    };
    x86_64-linux = {
      target = "x86_64-unknown-linux-gnu";
      hash = "sha256-P7OmaEcuExLu3XWYs/bFEazrwvZJfCk6XuBOuiSO7n4=";
    };
  };
  release = releases.${stdenv.hostPlatform.system};
in
  buildNpmPackage rec {
    pname = "vite-plus";
    version = "1.3.0";
    src = ./.;
    npmDepsHash = "sha256-5227zDAG4fRvpq8N2b6HwFak1oWzBLa/EK7IP4LbGus=";
    npmFlags = ["--ignore-scripts"];
    dontNpmBuild = true;

    cli = fetchurl {
      url = "https://github.com/voidzero-dev/vite-plus/releases/download/v${version}/vp-${release.target}.tar.gz";
      inherit (release) hash;
    };

    nativeBuildInputs = [autoPatchelfHook makeWrapper];
    buildInputs = [stdenv.cc.cc.lib];

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/lib/vite-plus/bin" "$out/bin"
      cp -r node_modules "$out/lib/vite-plus/"
      tar -xzf "$cli" -C "$out/lib/vite-plus/bin" vp
      # Nix owns installation; skip the upstream installer and shell mutations.
      touch "$out/lib/vite-plus/bin/.vp-setup-complete"
      makeWrapper "$out/lib/vite-plus/bin/vp" "$out/bin/vp" \
        --prefix PATH : ${lib.makeBinPath [nodejs]}
      runHook postInstall
    '';

    meta = {
      description = "Unified toolchain for JavaScript and TypeScript development";
      homepage = "https://viteplus.dev";
      license = lib.licenses.mit;
      mainProgram = "vp";
      platforms = builtins.attrNames releases;
    };
  }
