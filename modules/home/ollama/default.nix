{pkgs, ...}: {
  home.packages = with pkgs; [
    llama-cpp
    ollama
  ];
  services.ollama.enable = true;
}
