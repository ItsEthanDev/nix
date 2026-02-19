self: super: {
  opencode = super.opencode.overrideAttrs (oldAttrs: rec {
    version = "1.2.6";
    src = super.fetchFromGitHub {
      owner = "anomalyco";
      repo = "opencode";
      tag = "v${version}";
      hash = "sha256-43vPMyO7DsAgKrh0Wmt7jLDYCWUsaj30nBITreyYgX8=";
    };
  });
}
