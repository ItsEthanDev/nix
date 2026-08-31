{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      opts = {
        autoindent = lib.mkDefault true;
        autoread = lib.mkDefault true;
        breakindent = lib.mkDefault true;
        clipboard = lib.mkDefault "unnamedplus";
        conceallevel = lib.mkDefault 2;
        cursorline = lib.mkDefault true;
        cursorlineopt = lib.mkDefault "number";
        expandtab = lib.mkDefault true;
        exrc = lib.mkDefault true;
        fillchars = {
          foldopen = lib.mkDefault "";
          foldclose = lib.mkDefault "";
          fold = lib.mkDefault " ";
          foldsep = lib.mkDefault " ";
          diff = lib.mkDefault "╱";
          eob = lib.mkDefault " ";
        };
        foldlevel = lib.mkDefault 99;
        foldmethod = lib.mkDefault "indent";
        foldtext = lib.mkDefault "";
        inccommand = lib.mkDefault "split";
        ignorecase = lib.mkDefault true;
        iskeyword = lib.mkDefault "@,48-57,_,192-255,-";
        linebreak = lib.mkDefault true;
        wrap = lib.mkDefault true;
        laststatus = lib.mkDefault 3;
        list = lib.mkDefault true;
        listchars = {
          tab = lib.mkDefault "» ";
          trail = lib.mkDefault "·";
          nbsp = lib.mkDefault "␣";
        };
        number = lib.mkDefault true;
        numberwidth = lib.mkDefault 2;
        pumblend = lib.mkDefault 10;
        pumheight = lib.mkDefault 10;
        relativenumber = lib.mkDefault true;
        ruler = lib.mkDefault false;
        scrolloff = lib.mkDefault 8;
        shiftround = lib.mkDefault true;
        shiftwidth = lib.mkDefault 2;
        showcmd = lib.mkDefault true;
        showcmdloc = lib.mkDefault "statusline";
        showmode = lib.mkDefault false;
        smartindent = lib.mkDefault true;
        softtabstop = lib.mkDefault 2;
        signcolumn = lib.mkDefault "yes";
        smartcase = lib.mkDefault true;
        splitbelow = lib.mkDefault true;
        splitright = lib.mkDefault true;
        switchbuf = lib.mkDefault "usetab";
        tabstop = lib.mkDefault 2;
        termguicolors = lib.mkDefault true;
        textwidth = lib.mkDefault 80;
        timeoutlen = lib.mkDefault 400;
        undofile = lib.mkDefault true;
      };
    };
  };
}
