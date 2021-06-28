require("which-key").setup { plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ...
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {0, 0, 0, 0}, -- extra window margin [top, right, bottom, left]
        padding = {0, 0, 0, 0} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
}

-- Set leader
if O.leader_key == ' ' or O.leader_key == 'space' then
    vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
    vim.g.mapleader = ' '
else
    vim.api.nvim_set_keymap('n', O.leader_key, '<NOP>', {noremap = true, silent = true})
    vim.g.mapleader = O.leader_key
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

-- no hl
-- vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<Leader>h', ':noh<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<Leader>h', ':let @/=""<CR>', {noremap = true, silent = true})

-- explorer
-- vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- telescope
-- vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files <CR>', {noremap = true, silent = true})

-- dashboard
-- vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})

-- Global search
-- vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>Telescope live_grep<cr>", {noremap = true, silent = true})

-- close buffer
-- vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap("n", "<leader>w", ":wa<CR>", {noremap = true, silent = true})

-- vim.api.nvim_set_keymap("n", "<leader>n", ":tabnew<CR>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap("n", "<leader>v", ":Vista<CR>", {noremap = true, silent = true})

-- pane controls
-- vim.api.nvim_set_keymap("n", "<leader>p", "<c-w>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap("n", "<leader><space>", ":Telescope commands<CR>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap("n", "<leader><space>", ":Commands<CR>", {noremap = true, silent = true})

-- open projects
-- vim.api.nvim_set_keymap('n', '<leader>p', ":lua require'telescope'.extensions.project.project{}<CR>", {noremap = true, silent = true})

-- TODO create entire treesitter section

-- TODO support vim-surround in the which-key menus

local mappings = {
    [" "] = {"<cmd>Commands<CR>", "Commands"},
    ["/"] = {"<cmd>Telescope live_grep<cr>", "Global search"},
    -- ["c"] = "Close Buffer",
    -- ["w"] = "Write Buffer",
    -- ["e"] = "Explorer",
    ["f"] = {':Telescope find_files <CR>', "Find File"},
    ["h"] = {':noh<CR>', "No Highlight"},
    ["v"] = {":Vista<CR>", "Vista"},
    ["p"] = {":lua require'telescope'.extensions.project.project{}<CR>", "Projects"},
    o = {
        name = "Open new...",
        s = {"<cmd>NvimTreeToggle<CR>", "Sidebar"},
        r = {"<cmd>:RnvimrToggle<cr>", "Ranger"},
        p = {"<cmd>e ~/.config/nvim/<cr>", "Edit Private Config"},
        t = {"<cmd>lua require'FTerm'.toggle()<CR>", "Terminal"},
        B = {"<cmd>lua _G.__fterm_broot()<CR>", "Broot"},
        P = {"<cmd>lua _G.__fterm_python()<CR>", "Python"},
        T = {"<cmd>lua _G.__fterm_top()<CR>", "System Monitor"},
        S = {"<cmd>lua _G.__fterm_spt()<CR>", "Spotify"},
        -- t = {"<cmd>FloatermToggle<CR>", "Terminal"},
        -- T = {"<cmd>FloatermNew --wintype=normal --height=8<CR>", "Terminal Below"},
        -- P = {"<cmd>FloatermNew python<CR>", "Python"},
        -- b = {"<cmd>FloatermNew broot<CR>", "Broot"},
        o = {"<cmd>!open '%:p:h'<CR>", "Open File Explorer"},
    },
    ["b"] = {
        name = "Buffer",
        w = {":w<CR>", "Write"},
        a = {":wa<CR>", "Write All"},
        c = {":BufferClose<CR>", "Close"},
        f = {"<cmd>LspFormatting<cr><cmd>write<cr>", "Format"},
        n = {"<cmd>tabnew<CR>", "New"},
        j = {"<cmd>BufferPick<cr>", "jump to buffer"},
        W = {"<cmd>BufferWipeout<cr>", "wipeout buffer"},
        e = {"<cmd>BufferCloseAllButCurrent<cr>", "close all but current buffer"},
        h = {"<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left"},
        l = {"<cmd>BufferCloseBuffersRight<cr>", "close all BufferLines to the right"},
        D = {"<cmd>BufferOrderByDirectory<cr>", "sort BufferLines automatically by directory"},
        L = {"<cmd>BufferOrderByLanguage<cr>", "sort BufferLines automatically by language"},
    },
    d = {
        name = "Debug",
        b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
        c = {"<cmd>DebugContinue<cr>", "Continue"},
        i = {"<cmd>DebugStepInto<cr>", "Step Into"},
        o = {"<cmd>DebugStepOver<cr>", "Step Over"},
        r = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl"},
        s = {"<cmd>DebugStart<cr>", "Start"}
    },
    g = {
        name = "Git",
        g = {"<cmd>lua _G.__fterm_gitui()<CR>", "Gitui"},
        m = {"<cmd>!smerge '%:p:h'<CR>", "Sublime Merge"},
        j = {"<cmd>NextHunk<cr>", "Next Hunk"},
        k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
        p = {"<cmd>PreviewHunk<cr>", "Preview Hunk"},
        r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
        R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
        s = {"<cmd>StageHunk<cr>", "Stage Hunk"},
        u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"},
        o = {"<cmd>Telescope git_status<cr>", "Open changed file"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
        C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"}
    },
    l = {
        name = "LSP",
        a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>LspFormatting<cr><cmd>write<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        h = {"<cmd>LspSaga hover_doc<cr>", "Hover"},
        -- h = {"<cmd>LspHover<cr>", "Hover"},
        l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
        R = {"<cmd>Telescope lsp_references<cr>", "References"},
        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
        x = {"<cmd>cclose<cr>", "Close Quickfix"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"},
        n = {"<cmd>LspGotoNext<cr>", "Next"},
        N = {"<cmd>LspGotoPrev<cr>", "Previous"},
        V = {"<cmd>Vista nvim_lsp<cr>", "Vista"},
    },
    L = {
        name = "Latex",
        f = {"<cmd>call vimtex#fzf#run()<cr>", "Fzf Find"},
        i = {"<cmd>VimtexInfo<cr>", "Project Information"},
        s = {"<cmd>VimtexStop<cr>", "Stop Project Compilation"},
        t = {"<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content"},
        v = {"<cmd>VimtexView<cr>", "View PDF"},
        c = {'<cmd>VimtexCompile<cr>', 'Compile Project Latex'},
        o = {'<cmd>VimtexCompileOutput<cr>', 'Compile Output Latex'},
    },
    t = {
        name = "Trouble",
        t = {"<cmd>TroubleToggle<cr>", "Trouble"},
        d = {"<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document"},
        w = {"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "References"},
        D = {"<cmd>TroubleToggle lsp_definitions<cr>", "Definitions"},
        q = {"<cmd>TroubleToggle quickfix<cr>", "Quick Fixes"},
        l = {"<cmd>TroubleToggle loclist<cr>", "Location List"},
        o = {"<cmd>TroubleToggle todo<cr>", "TODOs"},
    },
    s = {
        name = "Search",
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        B = {"<cmd>Telescope buffers<cr>", "Buffers"},
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>", "Find File (+Hidden)"},
        h = {"<cmd>Telescope help_tags<cr>", "Find Help"},
        m = {"<cmd>Telescope marks<cr>", "Marks"},
        M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
        r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
        R = {"<cmd>Telesope registers<cr>", "Registers"},
        t = {"<cmd>Telescope live_grep<cr>", "Text"},
        k = {"<cmd>Telescope keymaps<cr>", "Keymappings"},
        o = {"<cmd>TodoTelescope<cr>", "TODOs"},
        p = {"<cmd>Telescope commands<cr>", "Commands"}
    },
    r = {
        name = "Replace",
        f = {"<cmd>lua require('spectre').open_file_search()<cr>", "Current File"},
        p = {"<cmd>lua require('spectre').open()<cr>", "Project"}
    },
    S = {
        name = "Session",
        s = {"<cmd>SessionSave<cr>", "Save Session"},
        l = {"<cmd>SessionLoad<cr>", "Load Session"}
    },
    z = {
        name = "Zen",
        s = {"<cmd>TZBottom<cr>", "toggle status line"},
        t = {"<cmd>TZTop<cr>", "toggle tab bar"},
        z = {"<cmd>TZAtaraxis<cr>", "toggle zen"}
    }
}

local visualOpts = {
    mode = "v", -- Visual mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local visualMappings = {
    ["/"] = {"<cmd>CommentToggle<cr>", "Comment"},
    r = {
        name = "Replace",
        f = {"<cmd>lua require('spectre').open_visual({path = vim.fn.expand('%')})<cr>", "File"},
        p = {"<cmd>lua require('spectre').open_visual()<cr>", "Project"}
    }
}

local wk = require("which-key")
wk.register(mappings, opts)
wk.register(visualMappings, visualOpts)
