{
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  autoPatchelfHook,
  cairo,
  cups,
  dbus,
  dpkg,
  expat,
  fetchurl,
  fontconfig,
  freetype,
  glib,
  gtk3,
  lib,
  libayatana-appindicator,
  libcap_ng,
  libdrm,
  libGL,
  libglvnd,
  libnotify,
  libpulseaudio,
  libseccomp,
  libsecret,
  libuuid,
  libx11,
  libxcb,
  libxcomposite,
  libxdamage,
  libxext,
  libxfixes,
  libxkbcommon,
  libxrandr,
  libxshmfence,
  libxtst,
  makeWrapper,
  mesa,
  nspr,
  nss,
  OVMF,
  pango,
  pipewire,
  qemu_kvm,
  stdenv,
  systemd,
  vulkan-loader,
  wrapGAppsHook3,
  xdg-utils,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "claude-desktop";
  version = "3.6556.2";

  src = fetchurl {
    url = "https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_${finalAttrs.version}_amd64.deb";
    hash = "sha256-D27R8oRcMEGbhUWoMgZ210ZKGfYl4F4CkZI4qml47LQ=";
  };

  nativeBuildInputs = [dpkg autoPatchelfHook makeWrapper wrapGAppsHook3];
  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    glib
    gtk3
    libayatana-appindicator
    libcap_ng
    libdrm
    libGL
    libglvnd
    libnotify
    libpulseaudio
    libseccomp
    libsecret
    libuuid
    libx11
    libxcb
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxkbcommon
    libxrandr
    libxshmfence
    libxtst
    mesa
    nspr
    nss
    pango
    pipewire
    stdenv.cc.cc.lib
    systemd
    vulkan-loader
  ];
  dontWrapGApps = true;

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb --fsys-tarfile "$src" | tar -x --no-same-owner --no-same-permissions
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/lib" "$out/share"
    cp -r usr/lib/claude-desktop "$out/lib/"
    cp -r usr/share/applications usr/share/icons "$out/share/"
    # Store binaries cannot be setuid; retain Chromium's user-namespace sandbox.
    rm "$out/lib/claude-desktop/chrome-sandbox"
    runHook postInstall
  '';

  postFixup = ''
    makeWrapper "$out/lib/claude-desktop/claude-desktop" "$out/bin/claude-desktop" \
      "''${gappsWrapperArgs[@]}" \
      --prefix PATH : ${lib.makeBinPath [qemu_kvm xdg-utils]} \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [libglvnd libGL mesa vulkan-loader]} \
      --set-default OVMF_PATH ${OVMF.fd}/FV/OVMF_CODE.fd \
      --add-flags "--ozone-platform-hint=auto --password-store=gnome-libsecret"
    substituteInPlace "$out/share/applications/"*.desktop \
      --replace-fail "Exec=claude-desktop" "Exec=$out/bin/claude-desktop"
  '';

  meta = {
    description = "Claude Desktop repackaged from the official Linux distribution";
    homepage = "https://claude.ai";
    license = lib.licenses.unfree;
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    platforms = ["x86_64-linux"];
    mainProgram = "claude-desktop";
  };
})
