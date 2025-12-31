{...}: {
  programs.fish = {
    enable = true;
    binds = {
      "\\cy" = {
        command = "accept-autosuggestion";
        mode = "insert";
      };
    };
    interactiveShellInit = ''
      # Vi bindings
      fish_vi_key_bindings

      # Disables the startup greeting
      set fish_greeting

      # Sets the SHELL env variable to the fish location
      set -gx SHELL (which fish)

      # History expansion with !!
      function last_history_item
        echo $history[1]
      end
      abbr -a !! --position anywhere --function last_history_item
    '';
    shellAbbrs = {
      "!!" = "'history | head -1 | read cmd; eval $cmd'";
    };
  };
}
