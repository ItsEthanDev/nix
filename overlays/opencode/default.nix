final: prev: let
  version = "1.18.4";
  src = final.fetchFromGitHub {
    owner = "anomalyco";
    repo = "opencode";
    tag = "v${version}";
    hash = "sha256-tGMO5JktINO8kXAHFQftn+JCrzwvpmNipTa8V0aIfNI=";
  };
in {
  opencode = prev.opencode.overrideAttrs (oldAttrs: {
    inherit version src;

    passthru = oldAttrs.passthru // {
      node_modules = oldAttrs.passthru.node_modules.overrideAttrs {
        inherit version src;
        outputHash = "sha256-jMZSDlqNObSmWJZ0Xn0IwfYC2+mBbRYorfgD5Y2sHWs=";
      };
    };
  });
}
