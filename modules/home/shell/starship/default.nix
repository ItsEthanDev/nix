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
      git_branch = {
        format = "[$branch(:$remote_branch)]($style) ";
      };
      hostname.ssh_symbol = "";
      nodejs.disabled = true;
      package.disabled = true;
      rust.disabled = true;
      username.disabled = true;
    };
  };
}
