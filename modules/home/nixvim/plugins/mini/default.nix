{...}: {
  imports = [
    ./ai.nix
    ./starter.nix
  ];

  programs.nixvim.plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      basics.enable = true;
      bracketed.enable = true;
      cmdline.enable = true;
      comment.enable = true;
      completion.enable = true;
      cursorword.enable = true;
      diff.enable = true;
      git.enable = true;
      hipatterns.enable = true;
      icons.enable = true;
      indentscope.enable = true;
      move.enable = true;
      pairs.enable = true;
      pick.enable = true;
      snippets.enable = true;
      splitjoin.enable = true;
      surround.enable = true;
      trailspace.enable = true;
    };
  };
}
