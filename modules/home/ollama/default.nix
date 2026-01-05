{pkgs, ...}: {
  home.packages = with pkgs; [
    llama-cpp
  ];
  services.ollama.enable = true;
}
