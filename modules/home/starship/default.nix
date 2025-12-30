{...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableTransience = true;
    settings = {
      bun.disabled = true;
      cmd_duration.disabled = true;
      gcloud.disabled = true;
      hostname.ssh_symbol = "";
      nodejs.disabled = true;
      username.disabled = true;
    };
  };
}
