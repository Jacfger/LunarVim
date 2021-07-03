-- Because lspinstall don't support zig yet,
-- So we need zls preset in global lib
-- Further custom install zls in 
-- https://github.com/zigtools/zls/wiki/Downloading-and-Building-ZLS
require'lspconfig'.zls.setup {
    root_dir = require'lspconfig'.util.root_pattern(".git", "build.zig",
                                                    "zls.json"),
    on_attach = require'lsp'.common_on_attach
    -- cmd = {DATA_PATH .. "/lspinstall/zig/zls/zls"}, -- TODO: Is this really necessary
}

require('lv-utils').define_augroups({
    _zig_autoformat = {
        {'BufWritePre', '*.zig', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'},
        {'BufEnter', '*.zig', [[setlocal commentstring=//\ %s]]}
    }
})

vim.cmd("setl expandtab tabstop=8 softtabstop=4 shiftwidth=4")
