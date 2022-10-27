-- TODO: inline these variables
local conf = {
  conceal = 2,
  -- theme = O.lighttheme,
  fontsize = 13,
  filetypes = { "tex", "bib" },
  texlab = {
    aux_directory = ".",
    bibtex_formatter = "texlab",
    build = {
      executable = "tectonic",
      args = {
        -- Input
        "%f",
        -- Flags
        "--synctex",
        "--keep-logs",
        "--keep-intermediates",
        -- Options
        -- OPTIONAL: If you want a custom out directory,
        -- uncomment the following line.
        --"--outdir out",
      },
      forwardSearchAfter = true,
      onSave = true,
    },
    chktex = { on_edit = true, on_open_and_save = true },
    diagnostics_delay = vim.opt.updatetime,
    formatter_line_length = 999,
    forward_search = {
      args = {},
      executable = "",
    },
    latexFormatter = "latexindent",
    latexindent = { modify_line_breaks = false },
  },
}
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "texlab" })
require("lspconfig")["texlab"].setup({
  filetypes = conf.filetypes,
  settings = {
    texlab = conf.texlab,
  },
})

-- require("lvim.lsp.config").lspconfig "texlab" {
--   filetypes = conf.filetypes,
--   settings = {
--     texlab = conf.texlab,
--   },
-- }
-- vim.opt_local.wrap = 1
-- vim.opt_local.spell = 1
-- vim.opt.number = false
-- vim.opt.relativenumber = false

vim.keymap.set("n", "j", [[v:count ? (v:count > ]] .. 5 .. [[ ? "m'" . v:count : '') . 'j' : 'gj']],
  { noremap = true, silent = true, expr = true })
vim.keymap.set("n", "k", [[v:count ? (v:count > ]] .. 5 .. [[ ? "m'" . v:count : '') . 'k' : 'gk']],
  { noremap = true, silent = true, expr = true })
vim.keymap.set("x", "j", [[v:count ? (v:count > ]] .. 5 .. [[ ? "m'" . v:count : '') . 'j' : 'gj']],
  { noremap = true, silent = true, expr = true })
vim.keymap.set("x", "k", [[v:count ? (v:count > ]] .. 5 .. [[ ? "m'" . v:count : '') . 'k' : 'gk']],
  { noremap = true, silent = true, expr = true })

vim.keymap.set("v", "<C-b>", "Smb", { silent = true, buffer = 0 })
vim.keymap.set("v", "<C-t>", "Smi", { silent = true, buffer = 0 })
vim.keymap.set("n", "<C-b>", "ysiwmb", { silent = true, buffer = 0 })
vim.keymap.set("n", "<C-t>", "ysiwmi", { silent = true, buffer = 0 })
vim.keymap.set("i", "<C-b>", "<cmd>normal ysiwmb<cr>", { silent = true, buffer = 0 })
vim.keymap.set("i", "<C-t>", "<cmd>normal ysiwmi<cr>", { silent = true, buffer = 0 })

-- require("lv-lightspeed").au_unconceal(conf.conceal)

-- require("lv-utils").define_augroups {
--   _general_lsp = {
--     { "CursorHold,CursorHoldI", "<buffer>", "lua vim.lsp.buf.formatting()" },
--     { "CursorMoved,TextChanged,InsertEnter", "<buffer>", "lua vim.lsp.buf.cancel_formatting()" },
--   },
-- }

-- require("cmp").setup.buffer { completion = { autocomplete = false } }
-- local sources = {
--   {
--     { name = "luasnip" },
--     { name = "path" },
--     { name = "copilot" },
--     { name = "nvim_lsp" },
--     { name = "calc" },
--   },
-- }
-- require("cmp").setup.buffer { sources = require("cmp").config.sources(sources) }

-- require("luasnip").add_snippets("tex", M.snippets)
-- require("luasnip").add_snippets("tex", M.autosnippets, { type = "autosnippets" })

-- require("lv-pairs.sandwich").add_local_recipes(M.sandwich_recipes)
-- vim.b.sandwich_tex_marks_recipes = vim.fn.deepcopy(M.sandwich_marks_recipes) -- TODO: idk what this does
-- M.sandwhich_mark_recipe_fn()

require("coexistence.which-key-mapping").localleader({
  f = { "<cmd>call vimtex#fzf#run()<cr>", "Fzf Find" },
  i = { "<cmd>VimtexInfo<cr>", "Project Information" },
  s = { "<cmd>VimtexStop<cr>", "Stop Project Compilation" },
  t = { "<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content" },
  v = { "<cmd>VimtexView<cr>", "View PDF" },
  -- c = { utils.conceal_toggle, "Toggle Conceal" },
  b = { "<cmd>VimtexCompile<cr>", "Compile" },
  o = { "<cmd>VimtexCompileOutput<cr>", "Compile Output" },
  e = { "<cmd>VimtexErrors<cr>", "Errors" },
  l = { "<cmd>TexlabBuild<cr>", "Texlab Build" },
  n = {
    function()
      require("nabla").action()
    end,
    "Nabla",
  },
  m = { "<cmd>VimtexToggleMain<cr>", "Toggle Main File" },
  a = { "<cmd>AirLatex<cr>", "Air Latex" },
}, {})

-- require("lv-utils").define_augroups { _vimtex_event = {
--   { "InsertLeave", "*.tex", "VimtexCompile" },
-- } }
