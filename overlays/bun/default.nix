final: prev: let
  version = "1.4.0";
  sources = {
    "aarch64-darwin" = final.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-darwin-aarch64.zip";
      hash = "sha256-xmnpf2Fk4cluBwF0jbmN+ndJKQjL2DlMdVcTSnNd44E=";
    };
    "aarch64-linux" = final.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-aarch64.zip";
      hash = "sha256-SxozLuhhmD65O8/m93D/+U4+MbLDiL2uo8jtNeWO7Q4=";
    };
    "x86_64-linux" = final.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-linux-x64-baseline.zip";
      hash = "sha256-GE+0WV8NQBohfPfHjBvEMLqDMU2reouUgFurv3+nCX8=";
    };
  };
in {
  bun = prev.bun.overrideAttrs {
    inherit version;
    passthru = builtins.removeAttrs prev.bun.passthru ["updateScript"] // {inherit sources;};
    src =
      sources.${final.stdenv.hostPlatform.system}
      or (throw "Unsupported system: ${final.stdenv.hostPlatform.system}");
  };
}
