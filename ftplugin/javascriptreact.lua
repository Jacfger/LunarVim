require("lsp.tsserver-ls").setup()

if O.lang.javascript.efm.active == true then
  require("lsp.efm-ls").generic_setup { "javascriptreact" }
end

vim.cmd "setl ts=2 sw=2"
