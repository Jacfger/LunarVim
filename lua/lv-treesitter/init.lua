-- if not package.loaded['nvim-treesitter'] then return end
--
-- Custom parsers
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.make = {
--     install_info = {
--         url = "https://github.com/alemuller/tree-sitter-make", -- local path or git repo
--         files = {"src/parser.c"},
--         requires_generate_from_grammar = true
--     }
-- }

parser_config.just = {
  install_info = {
    url = "~/.local/share/nvim/site/pack/tree-sitter-just", -- local path or git repo
    files = { "src/parser.c", "src/scanner.cc" },
  },
  -- filetype = "just", -- if filetype does not agrees with parser name
  -- used_by = {"bar", "baz"} -- additional filetypes that use this parser
}

-- Custom text objects
local textobj_prefixes = O.treesitter.textobj_prefixes
local textobj_suffixes = O.treesitter.textobj_suffixes
local textobj_sel_keymaps = {}
local textobj_swap_keymaps = {}
local textobj_move_keymaps = {
  enable = O.plugin.ts_textobjects,
  set_jumps = true, -- whether to set jumps in the jumplist
  goto_next_start = {},
  goto_next_end = {},
  goto_previous_start = {},
  goto_previous_end = {},
}
for obj, suffix in pairs(textobj_suffixes) do
  if textobj_prefixes["goto_next"] ~= nil then
    textobj_move_keymaps["goto_next_start"][textobj_prefixes["goto_next"] .. suffix[1]] = "@" .. obj .. ".outer"
    textobj_move_keymaps["goto_next_end"][textobj_prefixes["goto_next"] .. suffix[2]] = "@" .. obj .. ".outer"
  end
  if textobj_prefixes["goto_previous"] ~= nil then
    textobj_move_keymaps["goto_previous_start"][textobj_prefixes["goto_previous"] .. suffix[2]] = "@" .. obj .. ".outer"
    textobj_move_keymaps["goto_previous_end"][textobj_prefixes["goto_previous"] .. suffix[1]] = "@" .. obj .. ".outer"
  end

  if textobj_prefixes["inner"] ~= nil then
    textobj_sel_keymaps[textobj_prefixes["inner"] .. suffix[1]] = "@" .. obj .. ".inner"
  end
  if textobj_prefixes["outer"] ~= nil then
    textobj_sel_keymaps[textobj_prefixes["outer"] .. suffix[1]] = "@" .. obj .. ".outer"
  end

  if textobj_prefixes["swap"] ~= nil then
    textobj_swap_keymaps[textobj_prefixes["swap"] .. suffix[1]] = "@" .. obj .. ".inner"
  end
end

-- Add which key menu entries
local status, wk = pcall(require, "which-key")
if status then
  local normal = {
    mode = "n", -- Normal mode
  }
  local operators = {
    mode = "o", -- Operator mode
  }
  wk.register(textobj_sel_keymaps, operators)
  wk.register({
    ["m"] = "Hint Objects",
    ["."] = "Textsubject",
    [";"] = "Textsubject-big",
  }, operators)
  wk.register(textobj_swap_keymaps, normal)
  wk.register({
    [textobj_prefixes["swap"]] = "Swap",
    -- [textobj_prefixes["goto_next"]] = "Jump [",
    -- [textobj_prefixes["goto_previous"]] = "Jump ]"
  }, normal)
  wk.register(textobj_move_keymaps["goto_next_start"], normal)
  wk.register(textobj_move_keymaps["goto_next_end"], normal)
  wk.register(textobj_move_keymaps["goto_previous_start"], normal)
  wk.register(textobj_move_keymaps["goto_previous_end"], normal)
end

require("nvim-treesitter.configs").setup {
  ensure_installed = O.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = O.treesitter.ignore_install,
  matchup = {
    enable = O.plugin.matchup.active,
    -- disable = { "c", "ruby" },  -- list of language that will be disabled
  },
  pairs = {
    enable = O.plugin.ts_matchup.active,
    -- disable = {}, -- list of languages to disable
    highlight_pair_events = { "CursorMoved" }, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
    highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
    goto_right_end = false, -- whether to go to the end of the right partner or the beginning
    -- TODO: call matchup?
    -- fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
    -- fallback_cmd_normal = "normal! <Plug>(matchup-%)", -- What command to issue when we can't find a pair (e.g. "normal! %")
    fallback_cmd_normal = "call matchup#motion#find_matching_pair(0, 1)", -- What command to issue when we can't find a pair (e.g. "normal! %")
    keymaps = {
      goto_partner = "%",
    },
  },
  highlight = {
    enable = O.treesitter.active, -- false will disable the whole extension
    additional_vim_regex_highlighting = O.treesitter.additional_vim_regex_highlighting,
    disable = { "latex" },
  },
  context_commentstring = {
    enable = O.plugin.ts_context_commentstring.active,
    config = { css = "// %s" },
  },
  -- indent = {enable = true, disable = {"python", "html", "javascript"}},
  -- TODO seems to be broken
  indent = { enable = { "javascriptreact" } },
  autotag = { enable = O.plugin.ts_autotag.active },
  textobjects = {
    swap = {
      enable = O.plugin.ts_textobjects,
      swap_next = textobj_swap_keymaps,
    },
    move = textobj_move_keymaps,
    select = {
      enable = O.plugin.ts_textobjects,
      keymaps = textobj_sel_keymaps,
    },
  },
  textsubjects = {
    enable = O.plugin.ts_textsubjects,
    keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-container-outer" },
  },
  playground = {
    enable = O.plugin.ts_playground.active,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  rainbow = {
    enable = O.plugin.ts_rainbow.active,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<leader>rt",
      },
    },
    highlight_definitions = { enable = true },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition_lsp_fallback = "gd",
        goto_definition = "<leader>lnd",
        list_definitions = "<leader>lnD",
        -- list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
