return {
  {
    "folke/sidekick.nvim",
    opts = function()
      -- Accept inline suggestions or next edits
      LazyVim.cmp.actions.ai_nes = function()
        local Nes = require("sidekick.nes")
        if Nes.have() and (Nes.jump() or Nes.apply()) then
          return true
        end
      end
      Snacks.toggle({
        name = "Sidekick NES",
        get = function()
          return require("sidekick.nes").enabled
        end,
        set = function(state)
          require("sidekick.nes").enable(state)
        end,
      }):map("<leader>uN")
      -- Return config with NES disabled by default
      return {
        nes = {
          enabled = false,
        },
        cli = {
          win = {
            keys = {
              -- Disable Sidekick's <C-p> to avoid conflict with OpenCode
              prompt = false,
            },
          },
        },
      }
    end,
    keys = {
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Open OpenCode",
      },
    },
  },
}
