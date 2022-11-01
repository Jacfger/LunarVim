local M = {}

function M.setup()
  vim.g.neoterm_default_mod = "FocusSplitNicely"
  vim.g.neoterm_autoinsert = 1
  vim.g.neoterm_autoscroll = 1
  vim.g.neoterm_shell = "fish"
  vim.g.neoterm_bracketed_paste = 1
  vim.g.neoterm_repl_python = { "ipython" }
  vim.g.neoterm_repl_lua = { "croissant" }
  -- vim.g.neoterm_default_mod = 'vertical'
  vim.g.neoterm_repl_python = { "ipython" }
  vim.g.neoterm_repl_ipy_magic = 0
  vim.g.neoterm_repl_python_cellmarker = '# %%'
  -- vim.g.neoterm_repl_python = "['conda activate venv', 'clear', 'ipython']"

  -- TODO: neoterm doesn't invoke ipython
end

return M
