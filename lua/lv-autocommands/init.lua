local utils = require('lv-utils')

local auto_formatters = {            }

local python_autoformat = {'BufWritePre', '*.py', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
if O.lang.python.autoformat then table.insert(auto_formatters, python_autoformat) end

local javascript_autoformat = {'BufWritePre', '*.js', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
local javascriptreact_autoformat = {'BufWritePre', '*.jsx', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
local typescript_autoformat = {'BufWritePre', '*.ts', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
local typescriptreact_autoformat = {'BufWritePre', '*.tsx', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
if O.lang.tsserver.autoformat then
    table.insert(auto_formatters, javascript_autoformat)
    table.insert(auto_formatters, javascriptreact_autoformat)
    table.insert(auto_formatters, typescript_autoformat)
    table.insert(auto_formatters, typescriptreact_autoformat)
end

local lua_format = {'BufWritePre', '*.lua', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
if O.lang.lua.autoformat then table.insert(auto_formatters, lua_format) end

local json_format = {'BufWritePre', '*.json', 'lua vim.lsp.buf.formatting_sync(nil, 1000)'}
if O.lang.json.autoformat then table.insert(auto_formatters, json_format) end

local ruby_format = {'BufWritePre', '*.rb', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
if O.lang.ruby.autoformat then table.insert(auto_formatters, ruby_format) end

local go_format = {'BufWritePre', '*.go', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
if O.lang.go.autoformat then table.insert(auto_formatters, go_format) end

local c_autoformat = {'BufWritePre', '*.c', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
local cpp_autoformat = {'BufWritePre', '*.cpp', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
local cc_autoformat = {'BufWritePre', '*.cc', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
local h_autoformat = {'BufWritePre', '*.h', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
local hpp_autoformat = {'BufWritePre', '*.hpp', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
if O.lang.clang.autoformat then
    table.insert(auto_formatters, c_autoformat)
    table.insert(auto_formatters, cpp_autoformat)
    table.insert(auto_formatters, cc_autoformat)
    table.insert(auto_formatters, h_autoformat)
    table.insert(auto_formatters, hpp_autoformat)
end

local rust_format = {'BufWritePre', '*.rs', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
if O.lang.rust.autoformat then table.insert(auto_formatters, rust_format) end

-- vim.api.nvim_command('au! BufRead,BufNewFile *.fish set filetype=fish')

-- Autosave
vim.api.nvim_command('au FocusLost * silent! wa')
vim.api.nvim_command(':set autowriteall')

utils.define_augroups({
    _general_settings = {
        {'TextYankPost', '*', 'lua require(\'vim.highlight\').on_yank({higroup = \'Search\', timeout = 200})'},
        {'BufWinEnter', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        {'BufRead', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        {'BufNewFile', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
        {'VimLeavePre', '*', 'set title set titleold='},
        {'FileType', 'qf', 'set nobuflisted'},
        {'BufWinEnter', 'lv-config.lua', 'PackerCompile'},
        {'BufWinLeave', 'lv-config.lua', 'PackerCompile'},
        {'BufWritePost', 'lv-config.lua', 'PackerCompile'}

        -- {'User', 'GoyoLeave', 'lua require(\'galaxyline\').disable_galaxyline()'},
        -- {'User', 'GoyoEnter', 'lua require(\'galaxyline\').galaxyline_augroup()'},
    },
    _java = {
        -- {'FileType', 'java', 'luafile '..CONFIG_PATH..'/lua/lsp/java-ls.lua'},
        {'FileType', 'java', 'nnoremap ca <Cmd>lua require(\'jdtls\').code_action()<CR>'}
    },

    _go = {
        -- Go generally requires Tabs instead of spaces.
        {'FileType', 'go', 'setlocal tabstop=4'},
        {'FileType', 'go', 'setlocal shiftwidth=4'},
        {'FileType', 'go', 'setlocal softtabstop=4'},
        {'FileType', 'go', 'setlocal noexpandtab'},
    },
    _dashboard = {
        -- seems to be nobuflisted that makes my stuff disapear will do more testing
        {
            'FileType', 'dashboard',
            'setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= '
        }, {'FileType', 'dashboard', 'set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2'}
    },
    _markdown = {{'FileType', 'markdown', 'setlocal wrap'}, {'FileType', 'markdown', 'setlocal spell'},
        -- {'FileType', 'markdown', 'lua vim.o.guifont = "FiraCode Nerd Font:h15"'},
    },
    _solidity = {
        {'BufWinEnter', '.sol', 'setlocal filetype=solidity'}, {'BufRead', '*.sol', 'setlocal filetype=solidity'},
        {'BufNewFile', '*.sol', 'setlocal filetype=solidity'}
    },
    _fish = {
        {'BufWinEnter', '.fish', 'setlocal filetype=fish'}, {'BufRead', '*.fish', 'setlocal filetype=fish'},
        {'BufNewFile', '*.fish', 'setlocal filetype=fish'}
    },
    _gemini = {
        {'BufWinEnter', '.gmi', 'setlocal filetype=markdown'}, {'BufRead', '*.gmi', 'setlocal filetype=markdown'},
        {'BufNewFile', '*.gmi', 'setlocal filetype=markdown'}
    },
    _latex = {
        {'FileType', 'latex', 'VimtexCompile'},
        {'FileType', 'latex', 'setlocal wrap'},
        {'FileType', 'latex', 'setlocal spell'},
        -- {'FileType', 'latex', 'lua vim.o.guifont = "FiraCode Nerd Font:h15'},
    },
    _buffer_bindings = {
        {'FileType', 'dashboard', 'nnoremap <silent> <buffer> q :q<CR>'},
        {'FileType', 'lspinfo', 'nnoremap <silent> <buffer> q :q<CR>'},
        {'FileType', 'floaterm', 'nnoremap <silent> <buffer> q :q<CR>'},
        {'FileType', 'rnvimr', 'tnoremap <silent> <buffer> <nowait> - <ESC>:q<CR>'},
        {'FileType', 'rnvimr', 'inoremap <silent> <buffer> <nowait> - <ESC>:q<CR>'},
        -- {'FileType', 'latex', 'set conceallevel=2'},
    },
    _auto_formatters = auto_formatters
})
