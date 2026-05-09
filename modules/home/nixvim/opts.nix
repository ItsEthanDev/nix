_: {
  programs.nixvim = {
    opts = {
      autoread = true;
      breakindent = true;
      clipboard = "unnamedplus";
      conceallevel = 2;
      cursorline = true;
      cursorlineopt = "number";
      expandtab = true;
      fillchars = {
        foldopen = "";
        foldclose = "";
        fold = " ";
        foldsep = " ";
        diff = "╱";
        eob = " ";
      };
      foldlevel = 99;
      foldmethod = "indent";
      foldtext = "";
      inccommand = "split";
      ignorecase = true;
      laststatus = 3;
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      number = true;
      numberwidth = 2;
      pumblend = 10;
      pumheight = 10;
      relativenumber = true;
      ruler = false;
      scrolloff = 8;
      shiftround = true;
      shiftwidth = 2;
      showcmd = true;
      showcmdloc = "statusline";
      showmode = false;
      smartindent = true;
      softtabstop = 2;
      signcolumn = "yes";
      smartcase = true;
      splitbelow = true;
      splitright = true;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 400;
      undofile = true;
    };
  };
}
