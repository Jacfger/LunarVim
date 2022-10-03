local M = {}
M.plugins = {
  { "nathom/filetype.nvim" },
  {
    "windwp/nvim-spectre",
    module = "spectre",
    config = function()
      require("coexistence.extra.spectre").setup()
    end,
  },
  { "rmagatti/auto-session" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  -- Better neovim terminal
  -- TODO: add filetype.nvim?
  { "hrsh7th/cmp-cmdline", requires = "hrsh7th/nvim-cmp" },
  {
    "bfredl/nvim-luadev",
    config = function()
      require("coexistence.extra.luadev").setup()
    end,
    -- cmd = "LuadevStart", -- see lv-terms
  },
  {
    "beauwilliams/focus.nvim",
    config = function()
      local focus = require "focus"
      focus.setup {
        winhighlight = false,
        hybridnumber = false,
        relativenumber = true,
        number = true,
        cursorline = true,
        signcolumn = false,
      }
    end,
  },
  {
    "kassio/neoterm",
    config = function()
      require("coexistence.extra.neoterm").setup()
    end,
    -- cmd = { "T", "Tmap", "Tnew", "Ttoggle", "Topen", },
    -- keys = {
    --   "<Plug>(neoterm-repl-send)",
    --   "<Plug>(neoterm-repl-send-line)",
    -- },
  },
  {
    "bfredl/nvim-luadev", -- TODO
    config = function()
      require("lv-terms").luadev()
    end,
    cmd = "LuadevStart", -- see lv-terms
  },
  { "rafcamlet/nvim-luapad", cmd = { "Luapad", "LuaRun" } },

}

return M
