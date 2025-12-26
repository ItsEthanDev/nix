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
      fish_vi_key_bindings
      set fish_greeting
    '';
  };
}
