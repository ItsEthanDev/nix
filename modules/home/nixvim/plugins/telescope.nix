{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.nixvim) mkRaw;
in {
  home.packages = [pkgs.ripgrep];

  programs.nixvim = {
    plugins.telescope.enable = true;

    # keymaps = [
    #   {
    #     key = "<leader>ff";
    #     action = mkRaw ''function() require("telescope.builtin").find_files() end'';
    #     options.desc = "Find Files";
    #   }
    #   {
    #     key = "<leader>/";
    #     action = mkRaw ''
    #       function()
    #         local root = vim.fs.root(0, { ".git" }) or vim.loop.cwd()
    #         require("telescope.builtin").live_grep({ cwd = root })
    #       end
    #     '';
    #     options.desc = "Grep Root";
    #   }
    # ];
  };
}
