{...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableTransience = true;
    settings = {
      bun.disabled = true;
      gcloud.disabled = true;
      nodejs.disabled = true;
    };
  };
}
