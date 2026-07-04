_: {
  programs.nixvim.keymaps = [
    # Map
    {
      action = "<Cmd>lua MiniMap.toggle_focus()<CR>";
      key = "<space>mf";
      mode = ["n"];
      options = {
        desc = "Focus (toggle)";
      };
    }
    {
      action = "<Cmd>lua MiniMap.refresh()<CR>";
      key = "<space>mr";
      mode = ["n"];
      options = {
        desc = "Refresh";
      };
    }
    {
      action = "<Cmd>lua MiniMap.toggle_side()<CR>";
      key = "<space>ms";
      mode = ["n"];
      options = {
        desc = "Side (toggle)";
      };
    }
    {
      action = "<Cmd>lua MiniMap.toggle()<CR>";
      key = "<space>mt";
      mode = ["n"];
      options = {
        desc = "Toggle";
      };
    }
  ];
}
