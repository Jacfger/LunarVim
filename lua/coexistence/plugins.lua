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
      require("coexistence.extra.luadev").luadev()
    end,
    cmd = "LuadevStart", -- see lv-terms
  },
  { "rafcamlet/nvim-luapad", cmd = { "Luapad", "LuaRun" } },
  {
    "machakann/vim-sandwich",
    setup = function()
      vim.g.sandwich_no_default_key_mappings = 1
      vim.g.operator_sandwich_no_default_key_mappings = 1
      vim.g.textobj_sandwich_no_default_key_mappings = 1
    end,
    config = require("coexistence.extra.sandwich").setup(),
  },
  {
    "mg979/vim-visual-multi",
    setup = function()
      require("coexistence.extra.visual-multi").setup()
    end,
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        -- patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        --   -- For all filetypes
        --   -- Note that setting an entry here replaces all other patterns for this entry.
        --   -- By setting the 'default' entry below, you can control which nodes you want to
        --   -- appear in the context window.
        --   default = {
        --     'class',
        --     'function',
        --     'method',
        --   },
        -- },
      }
    end
  },
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      require("coexistence.extra.vimtex").config()
    end,
  },
}

return M
