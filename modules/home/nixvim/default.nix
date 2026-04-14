{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./autocmds.nix
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      breakindent = true;
      clipboard = "unnamedplus";
      autoread = true;
      cursorline = true;
      cursorlineopt = "number";
      expandtab = true;
      fillchars.eob = " ";
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
      relativenumber = true;
      ruler = false;
      scrolloff = 8;
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
      timeoutlen = 400;
      undofile = true;
    };
  };
}
