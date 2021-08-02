vim.g.neoterm_default_mod = "vertical"
vim.g.neoterm_autoinsert = 1
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_bracketed_paste = 1
vim.g.neoterm_repl_python = { "ipython" }
vim.g.neoterm_repl_lua = { "croissant" }
vim.g.neoterm_automap_keys = "<leader>te" -- FIXME: This doesnt work!?
--vim.g.neoterm_repl_python = "['conda activate venv', 'clear', 'ipython']"

local remap = vim.api.nvim_set_keymap
-- Use gx{text-object} in normal mode
-- Send selected contents in visual mode.
remap("v", "gx", "<Plug>(neoterm-repl-send)", {})
-- remap("v", "gx", ":TREPLSendSelection", {})
