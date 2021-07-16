if require("lv-utils").check_lsp_client_active "vuels" then
  return
end

require("lspconfig").vuels.setup {
  cmd = { DATA_PATH .. "/lspinstall/vue/node_modules/.bin/vls", "--stdio" },
  on_attach = require("lsp").common_on_attach,
  root_dir = require("lspconfig").util.root_pattern(".git", "vue.config.js", "package.json", "yarn.lock"),
  flags = O.lsp.flags,
}

if O.lang.vue.efm.active == true then
  require("lsp.efm-ls").generic_setup { "vue" }
end
