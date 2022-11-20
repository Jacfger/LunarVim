local function feedkeys(keys, o)
  if o == nil then
    o = "m"
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), o, false)
end

local function make_nN_pair(pair)
  return {
    function()
      vim.cmd [[normal! m']]
      if type(pair[1]) == "string" then
        feedkeys(pair[1])
      else
        pair[1]()
      end
    end,
    function()
      vim.cmd [[normal! m']]
      if type(pair[2]) == "string" then
        feedkeys(pair[2])
      else
        pair[2]()
      end
    end,
  }
end
local tsconfig = require('coexistence.options').tsoptions
local textobj_prefixes = tsconfig.textobj_prefixes
local textobj_suffixes = tsconfig.textobj_suffixes
local other_suffixes = tsconfig.other_suffixes
local textobj_sel_keymaps = {}
local textobj_swap_keymaps = {
  next = { [textobj_prefixes.swap_next .. other_suffixes.element[1]] = "TS Element" },
  previous = { [textobj_prefixes.swap_prev .. other_suffixes.element[1]] = "TS Element" },
}
local textobj_move_keymaps = {
  enable = true,
  set_jumps = true, -- whether to set jumps in the jumplist
  goto_next_start = {
    -- [textobj_prefixes.goto_next .. other_suffixes.scope[2]] = { outer_scope_nN[1], "Outer Scope" },
    -- [textobj_prefixes.goto_next .. other_suffixes.scope[1]] = { scope_nN[1], "Scope" },
    -- [textobj_prefixes.goto_next .. other_suffixes.element[1]] = { element_nN[1], "TS Element" },
  },
  goto_next_end = {},
  goto_previous_start = {
    -- [textobj_prefixes.goto_next .. other_suffixes.scope[1]] = { scope_nN[2], "Scope" },
    -- [textobj_prefixes.goto_next .. other_suffixes.element[1]] = { element_nN[2], "TS Element" },
  },
  goto_previous_end = {},
}
local textobj_move_wrap = true
for obj, suffix in pairs(textobj_suffixes) do
  local inner = "@" .. obj .. ".inner"
  local outer = "@" .. obj .. ".outer"
  local inners = make_nN_pair {
    function()
      require("nvim-treesitter.textobjects.move").goto_next_start(inner)
    end,
    function()
      require("nvim-treesitter.textobjects.move").goto_previous_start(inner)
    end,
  }
  local outers = make_nN_pair {
    function()
      require("nvim-treesitter.textobjects.move").goto_next_start(outer)
    end,
    function()
      require("nvim-treesitter.textobjects.move").goto_previous_start(outer)
    end,
  }
  local inner_next = { inners[1], "@" .. obj .. ".inner" }
  local inner_prev = { inners[2], "@" .. obj .. ".inner" }
  local outer_next = { outers[1], "@" .. obj .. ".outer" }
  local outer_prev = { outers[2], "@" .. obj .. ".outer" }

  if textobj_prefixes.goto_next ~= nil then
    textobj_move_keymaps.goto_next_start[textobj_prefixes.goto_next .. suffix[1]] = inner_next
    textobj_move_keymaps.goto_next_start[textobj_prefixes.goto_next .. suffix[2]] = outer_next
  end
  if textobj_prefixes.goto_previous ~= nil then
    textobj_move_keymaps.goto_previous_start[textobj_prefixes.goto_previous .. suffix[1]] = inner_prev
    textobj_move_keymaps.goto_previous_start[textobj_prefixes.goto_previous .. suffix[2]] = outer_prev
  end

  if textobj_prefixes.inner ~= nil then
    textobj_sel_keymaps[textobj_prefixes.inner .. suffix[1]] = "@" .. obj .. ".inner"
  end
  if textobj_prefixes.outer ~= nil then
    textobj_sel_keymaps[textobj_prefixes.outer .. suffix[1]] = "@" .. obj .. ".outer"
  end

  if textobj_prefixes.swap_next ~= nil then
    textobj_swap_keymaps.next[textobj_prefixes.swap_next .. suffix[1]] = "@" .. obj .. ".inner"
  end
  if textobj_prefixes.swap_prev ~= nil then
    textobj_swap_keymaps.previous[textobj_prefixes.swap_prev .. suffix[1]] = "@" .. obj .. ".inner"
  end
end

-- Add which key menu entries
local status, wk = pcall(require, "which-key")
if status then
  local normal = { mode = "n" } -- Normal mode
  local operators = { mode = "o" } -- Operator mode
  local register = wk.register
  register(textobj_sel_keymaps, operators)
  register({
    ["m"] = "Hint Objects",
    ["a" .. other_suffixes.scope[1]] = "Outer Scope",
    ["i" .. other_suffixes.element[1]] = "TS Element",
    ["a" .. other_suffixes.element[1]] = "TS Element",
    ["i" .. other_suffixes.subject[1]] = "Textsubject",
    ["a" .. other_suffixes.subject[1]] = "Textsubject-big",
  }, operators)
  register(textobj_swap_keymaps.next, normal)
  register(textobj_swap_keymaps.previous, normal)
  register({
    -- [textobj_prefixes.swap_next] = "Swap next",
    -- [textobj_prefixes.goto_next] = "Jump [",
    -- [textobj_prefixes.goto_previous] = "Jump ]"
  }, normal)
  register(textobj_move_keymaps.goto_next_start, normal)
  register(textobj_move_keymaps.goto_next_end, normal)
  register(textobj_move_keymaps.goto_previous_start, normal)
  register(textobj_move_keymaps.goto_previous_end, normal)
  if textobj_move_wrap then
    textobj_move_keymaps.goto_next_start = nil
    textobj_move_keymaps.goto_next_end = nil
    textobj_move_keymaps.goto_previous_start = nil
    textobj_move_keymaps.goto_previous_end = nil
  end
end

lvim.builtin.treesitter.textobjects = {
    swap = {
      enable = true,
      swap_next = textobj_swap_keymaps.next,
      swap_previous = textobj_swap_keymaps.previous,
    },
    move = textobj_move_keymaps,
    select = {
      enable = true,
      keymaps = textobj_sel_keymaps,
    },
}

local Log = require "lvim.core.log"
Log:warn("Set textobjects select?")
Log:warn(lvim.builtin.treesitter.textobjects.select.enable)
-- require("nvim-treesitter.configs").setup {
--   -- ensure_installed = tsconfig.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--   -- ignore_install = tsconfig.ignore_install,
--   matchup = {
--     enable = true,
--     -- disable = { "c", "ruby" },  -- list of language that will be disabled
--   },
--   pairs = {
--     enable = true,
--     -- disable = {}, -- list of languages to disable
--     highlight_pair_events = { "CursorMoved" }, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
--     highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
--     goto_right_end = false, -- whether to go to the end of the right partner or the beginning
--     -- TODO: call matchup?
--     -- fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
--     -- fallback_cmd_normal = "normal! <Plug>(matchup-%)",
--     fallback_cmd_normal = "call matchup#motion#find_matching_pair(0, 1)" or "normal! %",
--     keymaps = {
--       goto_partner = "%",
--     },
--   },
--   autotag = { enable = true },
--   -- textsubjects = {
--   --   enable = true,
--   --   keymaps = {
--   --     ["i" .. other_suffixes.subject[1]] = "textsubjects-smart",
--   --     ["a" .. other_suffixes.subject[1]] = "textsubjects-container-outer",
--   --   },
--   -- },
--   -- playground = {
--   --   enable = true,
--   --   disable = {},
--   --   updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
--   --   persist_queries = false, -- Whether the query persists across vim sessions
--   --   keybindings = {
--   --     toggle_query_editor = "o",
--   --     toggle_hl_groups = "i",
--   --     toggle_injected_languages = "t",
--   --     toggle_anonymous_nodes = "a",
--   --     toggle_language_display = "I",
--   --     focus_language = "f",
--   --     unfocus_language = "F",
--   --     update = "R",
--   --     goto_node = "<cr>",
--   --     show_help = "?",
--   --   },
--   -- },
--   -- refactor = {
--   --   smart_rename = {
--   --     enable = true,
--   --     keymaps = {
--   --       smart_rename = "<leader>rt", -- TODO: use my mini window UI for this
--   --     },
--   --   },
--   --   highlight_definitions = { enable = true },
--   --   navigation = {
--   --     enable = true,
--   --     keymaps = {
--   --       goto_definition_lsp_fallback = "gd",
--   --       goto_definition = "<leader>lnd",
--   --       list_definitions = "<leader>lnD",
--   --       -- list_definitions_toc = "gO",
--   --       goto_next_usage = "<leader>lnu",
--   --       goto_previous_usage = "<leader>lnU",
--   --     },
--   --   },
--   -- },
--   -- element_textobject = {
--   --   enable = true,
--   --   keymaps = {
--   --     [textobj_prefixes.swap_next .. other_suffixes.element[1]] = "swap_next_element",
--   --     [textobj_prefixes.swap_prev .. other_suffixes.element[1]] = "swap_prev_element",
--   --     ["i" .. other_suffixes.element[1]] = "inner_element",
--   --     ["a" .. other_suffixes.element[1]] = "an_element", -- around
--   --   },
--   --   set_jumps = true,
--   -- },
--   -- scope_textobject = {
--   --   enable = true,
--   --   keymaps = {
--   --     ["a" .. other_suffixes.scope[1]] = "a_scope",
--   --   },
--   --   set_jumps = true,
--   -- },
-- }

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
