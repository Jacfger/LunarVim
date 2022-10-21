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
    config = function()
      vim.cmd [[
  onoremap <Plug>(sandwich-line-helper) :normal! ^vg_<CR>
  nmap ys <Plug>(operator-sandwich-add)
  nmap <silent> yss <Plug>(operator-sandwich-add)<Plug>(sandwich-line-helper)
  nmap yS ysg_

  nmap ds <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  nmap dss <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
  nmap cs <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
  nmap css <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

  xmap S <Plug>(operator-sandwich-add)

  runtime autoload/repeat.vim
  if hasmapto('<Plug>(RepeatDot)')
    nmap . <Plug>(operator-sandwich-predot)<Plug>(RepeatDot)
  else
    nmap . <Plug>(operator-sandwich-dot)
  endif
  ]]


      local recipes = {}
      local add_recipes = function(recipes_)
        vim.list_extend(recipes, recipes_)
        vim.g["sandwich#recipes"] = recipes
      end
      add_recipes {
        {
          ["buns"] = { "s+", "s+" },
          ["regex"] = 1,
          ["kind"] = { "delete", "replace", "query" },
          ["input"] = { " " },
        },

        {
          ["buns"] = { "", "" },
          ["action"] = { "add" },
          ["motionwise"] = { "line" },
          ["linewise"] = 1,
          ["input"] = { "<CR>" },
        },

        {
          ["buns"] = { "^$", "^$" },
          ["regex"] = 1,
          ["linewise"] = 1,
          ["input"] = { "<CR>" },
        },

        {
          ["buns"] = { "<", ">" },
          ["expand_range"] = 0,
          ["input"] = { ">", "a" },
        },

        {
          ["buns"] = { "`", "`" },
          ["quoteescape"] = 1,
          ["expand_range"] = 0,
          ["nesting"] = 0,
          ["linewise"] = 0,
        },

        {
          ["buns"] = { '"', '"' },
          ["quoteescape"] = 1,
          ["expand_range"] = 0,
          ["nesting"] = 0,
          ["linewise"] = 0,
        },

        {
          ["buns"] = { "'", "'" },
          ["quoteescape"] = 1,
          ["expand_range"] = 0,
          ["nesting"] = 0,
          ["linewise"] = 0,
        },

        {
          ["buns"] = { "{", "}" },
          ["nesting"] = 1,
          ["skip_break"] = 1,
          ["input"] = { "{", "}", "B" },
        },

        {
          ["buns"] = { "[", "]" },
          ["nesting"] = 1,
          ["input"] = { "[", "]", "r" },
        },

        {
          ["buns"] = { "(", ")" },
          ["nesting"] = 1,
          ["input"] = { "(", ")", "b" },
        },

        {
          ["buns"] = "sandwich#magicchar#t#tag()",
          ["listexpr"] = 1,
          ["kind"] = { "add" },
          ["action"] = { "add" },
          ["input"] = { "t", "T" },
        },

        {
          ["buns"] = "sandwich#magicchar#t#tag()",
          ["listexpr"] = 1,
          ["kind"] = { "replace" },
          ["action"] = { "add" },
          ["input"] = { "T", "<" },
        },

        {
          ["buns"] = "sandwich#magicchar#t#tagname()",
          ["listexpr"] = 1,
          ["kind"] = { "replace" },
          ["action"] = { "add" },
          ["input"] = { "t" },
        },

        {
          ["external"] = { "<Plug>(textobj-sandwich-tag-i)", "<Plug>(textobj-sandwich-tag-a)" },
          ["noremap"] = 0,
          ["kind"] = { "delete", "textobj" },
          ["expr_filter"] = { 'operator#sandwich#kind() !=# "replace"' },
          ["linewise"] = 1,
          ["input"] = { "t", "T", "<" },
        },

        {
          ["external"] = { "<Plug>(textobj-sandwich-tag-i)", "<Plug>(textobj-sandwich-tag-a)" },
          ["noremap"] = 0,
          ["kind"] = { "replace", "query" },
          ["expr_filter"] = { 'operator#sandwich#kind() ==# "replace"' },
          ["input"] = { "T", "<" },
        },

        {
          ["external"] = { "<Plug>(textobj-sandwich-tagname-i)", "<Plug>(textobj-sandwich-tagname-a)" },
          ["noremap"] = 0,
          ["kind"] = { "replace", "textobj" },
          ["expr_filter"] = { 'operator#sandwich#kind() ==# "replace"' },
          ["input"] = { "t" },
        },

        {
          ["buns"] = { "sandwich#magicchar#f#fname()", '")"' },
          ["kind"] = { "add", "replace" },
          ["action"] = { "add" },
          ["expr"] = 1,
          ["input"] = { "f" },
        },

        {
          ["external"] = { "<Plug>(textobj-sandwich-function-ip)", "<Plug>(textobj-sandwich-function-i)" },
          ["noremap"] = 0,
          ["kind"] = { "delete", "replace", "query" },
          ["input"] = { "f" },
        },

        {
          ["external"] = { "<Plug>(textobj-sandwich-function-ap)", "<Plug>(textobj-sandwich-function-a)" },
          ["noremap"] = 0,
          ["kind"] = { "delete", "replace", "query" },
          ["input"] = { "F" },
        },

        {
          ["buns"] = 'sandwich#magicchar#i#input("operator")',
          ["kind"] = { "add", "replace" },
          ["action"] = { "add" },
          ["listexpr"] = 1,
          ["input"] = { "i" },
        },

        {
          ["buns"] = 'sandwich#magicchar#i#input("textobj", 1)',
          ["kind"] = { "delete", "replace", "query" },
          ["listexpr"] = 1,
          ["regex"] = 1,
          ["input"] = { "i" },
        },

        {
          ["buns"] = 'sandwich#magicchar#i#lastinput("operator", 1)',
          ["kind"] = { "add", "replace" },
          ["action"] = { "add" },
          ["listexpr"] = 1,
          ["input"] = { "I" },
        },

        {
          ["buns"] = 'sandwich#magicchar#i#lastinput("textobj")',
          ["kind"] = { "delete", "replace", "query" },
          ["listexpr"] = 1,
          ["regex"] = 1,
          ["input"] = { "I" },
        },

        {
          external = { "ic", "ac" },
          noremap = false,
          kind = { "delete", "replace", "query" },
          input = { "c" },
        },
        {
          external = { "ii", "ai" },
          noremap = false,
          kind = { "delete", "replace", "query" },
          input = { "i" },
        },
        {
          external = { "if", "af" },
          noremap = false,
          kind = { "delete", "replace", "query" },
          input = { "af" },
        },
        -- {
        --   buns = { {[']], [[']} },
        --   quoteescape = true,
        --   expand_range = false,
        --   nesting = false,
        --   input = { "q" },
        -- },
        -- {
        --   buns = { {["]], [["]} },
        --   quoteescape = true,
        --   expand_range = false,
        --   nesting = false,
        --   input = { "Q" },
        -- },
        {
          buns = { "{'`\"]", "['`\"}" },
          kind = { "delete", "replace", "query" },
          quoteescape = true,
          expand_range = false,
          nesting = false,
          input = { "q" },
          regex = 1,
        },
      }

      vim.keymap.set("x", "is", "<Plug>(textobj-sandwich-query-i)", { silent = true, remap = true })
      vim.keymap.set("x", "as", "<Plug>(textobj-sandwich-query-a)", { silent = true, remap = true })
      vim.keymap.set("o", "is", "<Plug>(textobj-sandwich-query-i)", { silent = true, remap = true })
      vim.keymap.set("o", "as", "<Plug>(textobj-sandwich-query-a)", { silent = true, remap = true })
      vim.keymap.set("x", "iq", "isq", { silent = true, remap = true })
      vim.keymap.set("x", "aq", "asq", { silent = true, remap = true })
      vim.keymap.set("o", "iq", "isq", { silent = true, remap = true })
      vim.keymap.set("o", "aq", "asq", { silent = true, remap = true })
      vim.keymap.set("x", "s", "<Plug>(operator-sandwich-add)", { silent = true, remap = true }) --
    end,
  },

}

return M
