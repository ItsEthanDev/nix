final: prev: let
  version = "1.17.13";
  src = final.fetchFromGitHub {
    owner = "anomalyco";
    repo = "opencode";
    tag = "v${version}";
    hash = "sha256-WE8+O+Od8M71fKoOOhE9CbTsJ0JMAi0ZajmYd//VG2k=";
  };
in {
  opencode = prev.opencode.overrideAttrs (oldAttrs: {
    inherit version src;

    node_modules = oldAttrs.node_modules.overrideAttrs {
      inherit version src;
      outputHash = "sha256-SUNfdHtASPh1mpxKvIKJ2GrDHAxmv7Gu7B7vr3PX5W4=";
    };
  });
}
