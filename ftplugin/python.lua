-- TODO: neoterm doesn't invoke ipython
-- vim.g.neoterm_repl_command = { "ipython" }
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
require("lspconfig")["pyright"].setup({
  flags = {
    debounce_text_changes = 200,
  }
})
