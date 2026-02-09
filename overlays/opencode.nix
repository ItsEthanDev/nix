self: super: {
  opencode = super.opencode.overrideAttrs (oldAttrs: rec {
    version = "1.1.53";
    src = super.fetchFromGitHub {
      owner = "anomalyco";
      repo = "opencode";
      tag = "v${version}";
      hash = "sha256-f6TVxKV9q2yEQ9r9VCTttXLqpOrYdTEKDUJs+MuQJCQ=";
    };
  });
}
