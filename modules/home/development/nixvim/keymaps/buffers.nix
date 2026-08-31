{
  config,
  lib,
  ...
}: let
  cfg = config.my.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.keymaps = [
      # Buffers
      {
        action = "<Cmd>lua MiniBufremove.delete()<CR>";
        key = "<space>bd";
        mode = ["n"];
        options = {
          desc = "Delete";
        };
      }
      {
        action = "<Cmd>lua MiniBufremove.delete(0, true)<CR>";
        key = "<space>bD";
        mode = ["n"];
        options = {
          desc = "Delete!";
        };
      }
    ];
  };
}
