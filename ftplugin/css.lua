if not require("lv-utils").check_lsp_client_active "cssls" then
  -- npm install -g vscode-css-languageserver-bin
  require("lspconfig").cssls.setup {
    cmd = {
      "node",
      DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
      "--stdio",
    },
    on_attach = require("lsp").common_on_attach,
    flags = O.lsp.flags,
  }
end

vim.cmd "setl ts=2 sw=2"

if O.lang.css.efm.active == true then
  require("lsp.efm-ls").generic_setup { "css" }
end
