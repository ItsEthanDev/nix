{
  alsa-lib,
  alsa-plugins,
  autoPatchelfHook,
  dpkg,
  fetchFromGitHub,
  fetchurl,
  gst_all_1,
  gtk3,
  lib,
  libsoup_3,
  openssl,
  stdenv,
  vulkan-loader,
  webkitgtk_4_1,
  wrapGAppsHook3,
  xdotool,
}: let
  releases = {
    aarch64-linux = {
      debArch = "arm64";
      hash = "sha256-DEVMRvnoT0C0pw9dC04NPpK+Mwih7GlHqwDOpS03SeU=";
    };
    x86_64-linux = {
      debArch = "amd64";
      hash = "sha256-N1n1/0Y4hoL76ORAEjzBIdx7eYTyxi1Zl0A6eYS9gnM=";
    };
  };
  release = releases.${stdenv.hostPlatform.system};
  xdotool_3 = xdotool.overrideAttrs {
    version = "3.20211022.1";
    src = fetchFromGitHub {
      owner = "jordansissel";
      repo = "xdotool";
      rev = "v3.20211022.1";
      hash = "sha256-XFiaiHHtUSNFw+xhUR29+2RUHOa+Eyj1HHfjCUjwd9k=";
    };
  };
in
  stdenv.mkDerivation rec {
    pname = "vibe";
    version = "3.2.2";

    src = fetchurl {
      url = "https://github.com/thewh1teagle/vibe/releases/download/v${version}/vibe_${version}_${release.debArch}.deb";
      inherit (release) hash;
    };

    nativeBuildInputs = [
      autoPatchelfHook
      dpkg
      wrapGAppsHook3
    ];

    buildInputs = [
      alsa-lib
      gst_all_1.gst-plugins-base
      gtk3
      libsoup_3
      openssl
      stdenv.cc.cc.lib
      webkitgtk_4_1
      xdotool_3
    ];

    unpackPhase = ''
      runHook preUnpack
      dpkg-deb -x "$src" .
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      cp -r usr "$out"
      runHook postInstall
    '';

    preFixup = ''
      gappsWrapperArgs+=(
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [vulkan-loader]}
        --set ALSA_PLUGIN_DIR ${alsa-plugins}/lib/alsa-lib
      )
    '';

    meta = {
      description = "Private, offline audio and video transcription";
      homepage = "https://github.com/thewh1teagle/vibe";
      license = lib.licenses.mit;
      mainProgram = "vibe";
      platforms = builtins.attrNames releases;
    };
  }
