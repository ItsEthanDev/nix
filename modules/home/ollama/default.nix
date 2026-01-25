{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    ollama = pkgs.ollama.overrideAttrs (oldAttrs: {
      version = "0.14.3";
      src = pkgs.fetchFromGitHub {
        owner = "ollama";
        repo = "ollama";
        tag = "v0.14.3";
        hash = "sha256-SVzJDuy5qXaqxE4HqiqVhoyGLTOt57370q8r3YV18Og=";
      };
      vendorHash = "sha256-WdHAjCD20eLj0d9v1K6VYP8vJ+IZ8BEZ3CciYLLMtxc=";
    });
  };

  home.packages = with pkgs; [
    llama-cpp
    ollama
  ];
  services.ollama.enable = true;
}
