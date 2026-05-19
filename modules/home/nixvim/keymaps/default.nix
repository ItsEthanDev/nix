_: {
  imports = [
    ./buffers.nix
    ./explore.nix
    ./find.nix
    ./git.nix
    ./lsp.nix
    ./map.nix
  ];

  programs.nixvim = {
    keymaps = [
      # Better up/down
      {
        action = "v:count == 0 ? 'gj' : 'j'";
        key = "j";
        mode = ["n" "x"];
        options = {
          desc = "Down";
          expr = true;
          silent = true;
        };
      }
      {
        action = "v:count == 0 ? 'gk' : 'k'";
        key = "k";
        mode = ["n" "x"];
        options = {
          desc = "Up";
          expr = true;
          silent = true;
        };
      }
      # Clear highlights on escape
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<Esc>";
        mode = ["n"];
        options = {
          desc = "clear search highlight";
          silent = true;
        };
      }
      # Better indent
      {
        action = "<gv";
        key = "<";
        mode = "x";
        options.silent = true;
      }
      {
        action = ">gv";
        key = ">";
        mode = "x";
        options.silent = true;
      }
    ];
  };
}
