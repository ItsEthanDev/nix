{...}: {
  homebrew = {
    enable = true;
  };

  environment.extraInit = ''
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  '';
}
