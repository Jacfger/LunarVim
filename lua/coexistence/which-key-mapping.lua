local M = {}

M.mappings = {
  opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  maps = {
    ["/"] = {
      function()
        require("spectre").open_file_search()
      end,
      "Spectre Search",
    },
    ["F"] = { "<cmd>Telescope find_files<cr>", "Find File" },
    ["f"] = { "<cmd>Telescope find_files<cr>", "Find All File" },
    b = {
      name = "Buffers",
      s = { "<cmd>BufferLinePick<cr>", "Switch to Tab" },
      j = { "<cmd>Telescope buffers<cr>", "Jump to Buffer by Name" },
      b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
      n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
      -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
      e = {
        "<cmd>BufferLinePickClose<cr>",
        "Pick which buffer to close",
      },
      L = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
      H = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      h = { "<cmd>BufferLineCyclePrev<cr>", "Close all to the right" },
      l = { "<cmd>BufferLineCycleNext<cr>", "Close all to the left" },
      D = {
        "<cmd>BufferLineSortByDirectory<cr>",
        "Sort by directory",
      },
      f = {
        function()
          vim.lsp.buf.format { async = true }
        end,
        "Format Buffer",
      },
    },
    [";"] = { require("telescope.builtin").commands, "Commands" },
    [" "] = { name = "Electric Boogaloo" },
    ["*"] = "Search obj",
    ["#"] = "Search(bwd) obj",
    -- [";"] = { "<cmd>Dashboard<cr>", "Dashboard" },
    ["j"] = { "Jump next (])" },
    ["k"] = { "Jump prev ([)" },
    ["J"] = { "Swap next ())" },
    ["K"] = { "Swap prev (()" },
    I = {
      name = "Interative Swap",
      S = { "<cmd><ISwap<cr>", "Interatively Swap" },
      s = { "<cmd><ISwap<cr>", "Interatively Swap With" },
    },
    x = {
      name = "Execute/Send",
      ["<cr>"] = "Neoterm AutoMap",
      ["m"] = { "<Plug>(neoterm-repl-send)", "Neoterm Send" },
      ["n"] = { "<Plug>(neoterm-repl-send-line)", "Neoterm Line" },
    },

    q = { "<C-W>q", "Quit" },
    Q = { "<C-W>q", "Quit" },
    o = {
      name = "Toggle window",
      -- s = { focus_fn.split_nicely, "Nice split" },
      o = { "<cmd>SidebarNvimToggle<cr>", "Sidebar.nvim" },
      -- e = { focus_fn.focus_max_or_equal, "Max/Equal splits" },
      f = { "<cmd>NvimTreeToggle<cr>", "File Sidebar" },
      u = { "<cmd>UndotreeToggle<cr>", "Undo tree" },
      r = { "<cmd>Ranger<cr>", "Ranger" },
      -- q = { utils.quickfix_toggle, "Quick fixes" },
      E = { "<cmd>!open '%:p:h'<cr>", "Open File Explorer" },
      v = { "<cmd>Vista nvim_lsp<cr>", "Vista" },
      -- ["v"] = { "<cmd>Vista<cr>", "Vista"},
      M = { vim.g.goneovim and "<cmd>GonvimMiniMap<cr>" or "<cmd>MinimapToggle<cr>", "Minimap" },
    },
    t = { name = "Terminals",
      ["<cr>"] = { "<cmd>Tnew<CR>", "Open Terminal" },
      ["<tab>"] = { "<cmd>Ttoggle<cr>", "Neoterm Toggle" },
      ["t"] = { "<cmd>Tnew<CR>", "T ..." },
      ["l"] = { "<cmd>Tls<cr>", "Neoterm list" },
    },
    p = { name = "Project (Tasks)" },
    T = {
      name = "Toggle Opts",
      w = { "<cmd>setlocal wrap!<cr>", "Wrap" },
      s = { "<cmd>setlocal spell!<cr>", "Spellcheck" },
      C = { "<cmd>setlocal cursorcolumn!<cr>", "Cursor column" },
      n = { "<cmd>setlocal number!<cr>", "Number column" },
      g = { "<cmd>setlocal signcolumn!<cr>", "Cursor column" },
      l = { "<cmd>setlocal cursorline!<cr>", "Cursor line" },
      h = { "<cmd>setlocal hlsearch<cr>", "hlsearch" },
      -- c = { utils.conceal_toggle, "Conceal" },
      -- f = { focus_fn.focus_toggle, "Focus.nvim" },
      -- TODO: Toggle comment visibility
    },
    -- b = {
    --   name = "Buffers",
    --   j = { "<cmd>BufferLinePick<cr>", "Jump to Tab" },
    --   s = { "<cmd>Telescope buffers<cr>", "Search Buffer Name" },
    --   w = { "<cmd>w<cr>", "Write" },
    --   a = { "<cmd>wa<cr>", "Write All" },
    --   c = { "<cmd>Bdelete!<cr>", "Close" },
    --   d = { "<cmd>bdelete!<cr>", "Close+Win" },

    --   h = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    --   l = { "<cmd>BufferLineCycleNext<cr>", "Next" },
    --   f = {
    --     function()
    --       vim.lsp.buf.format { async = true }
    --     end,
    --     "Format",
    --   },
    --   -- n = { "<cmd>tabnew<cr>", "New" },
    --   n = { "<cmd>enew<cr>", "New" },
    --   -- W = {"<cmd>BufferWipeout<cr>", "wipeout buffer"},
    --   -- e = {
    --   --     "<cmd>BufferCloseAllButCurrent<cr>",
    --   --     "close all but current buffer"
    --   -- },
    --   H = { "<cmd>BufferLineCloseLeft<cr>", "close all buffers to the left" },
    --   L = { "<cmd>BufferLineCloseRight<cr>", "close all BufferLines to the right" },

    --   -- l = { "<cmd>BufferLineSortByExtension<cr>", "sort BufferLines automatically by language" },
    --   D = { "<cmd>BufferLineSortByDirectory<cr>", "sort BufferLines automatically by directory" },
    -- },
    D = {
      -- " Available Debug Adapters:
      -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
      -- "
      -- " Adapter configuration and installation instructions:
      -- "
      -- "
      -- " Debug Adapter protocol:
      -- "   https://microsoft.github.io/debug-adapter-protocol/
      -- TODO: can use localleader for this??
      name = "Debug",
      U = {
        function()
          require("dapui").toggle()
        end,
        "Toggle DAP-UI",
      },
      v = {
        function()
          require("dapui").eval()
        end,
        "Eval",
      },
      t = {
        function()
          require("dap").toggle_breakpoint()
        end,
        "Toggle Breakpoint",
      },
      b = {
        function()
          require("dap").step_back()
        end,
        "Step Back",
      },
      c = {
        function()
          require("dap").continue()
        end,
        "Continue",
      },
      C = {
        function()
          require("dap").run_to_cursor()
        end,
        "Run To Cursor",
      },
      d = {
        function()
          require("dap").disconnect()
        end,
        "Disconnect",
      },
      g = {
        function()
          require("dap").session()
        end,
        "Get Session",
      },
      i = {
        function()
          require("dap").step_into()
        end,
        "Step Into",
      },
      o = {
        function()
          require("dap").step_over()
        end,
        "Step Over",
      },
      u = {
        function()
          require("dap").step_out()
        end,
        "Step Out",
      },
      p = {
        function()
          require("dap").pause.toggle()
        end,
        "Pause",
      },
      r = {
        function()
          require("dap").repl.toggle()
        end,
        "Toggle Repl",
      },
      s = {
        function()
          require("dap").continue()
        end,
        "Start",
      },
      q = {
        function()
          require("dap").stop()
        end,
        "Quit",
      },
    },
    g = {
      name = "Git",
      -- g = { require("lv-terms").ftopen "gitui", "Gitui" },
      -- v = { require("lv-terms").ftopen "verco", "Verco" },
      m = { "<cmd>!smerge '%:p:h'<cr>", "Sublime Merge" },
      L = { "<cmd>GitBlameToggle<cr>", "Blame Toggle" },
      -- l = { gitsigns_fn.blame_line, "Blame" },
      -- p = { gitsigns_fn.preview_hunk, "Preview Hunk" },
      -- r = { gitsigns_fn.reset_hunk, "Reset Hunk" },
      -- R = { gitsigns_fn.reset_buffer, "Reset Buffer" },
      -- s = { gitsigns_fn.stage_hunk, "Stage Hunk" },
      -- u = { gitsigns_fn.undo_stage_hunk, "Undo Stage Hunk" },
      -- o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      -- c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      -- C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
      d = {
        name = "Diffview",
        o = { "<cmd>DiffviewOpen<cr>", "Open" },
        h = { "<cmd>DiffviewFileHistory<cr>", "History" },
        O = { ":DiffviewOpen ", "Open ..." },
        H = { ":DiffviewFileHistory ", "History ..." },
      },
      ["<CR>"] = { "<cmd>Git<cr>", "Fugitive Status" },
      [" "] = { ":Git ", "Fugitive ..." },
    },
    l = {
      name = "LSP",
      i = {
        l = { "<cmd>LspInfo<cr>", "LSP" },
        n = { "<cmd>NullLsInfo<cr>", "Null-ls" },
        i = { "<cmd>LspInstallInfo<cr>", "LspInstall" },
        t = { "<cmd>TSConfigInfo<cr>", "Treesitter" },
      },
      -- h = { lspbuf.hover, "Hover (gh)" },
      -- a = { do_code_action, "Code Action (K)" },
      -- k = { vim.lsp.codelens.run, "Run Code Lens (gK)" },
      -- t = { lspbuf.type_definition, "Type Definition" },
      -- f = { lspbuf.formatting, "Format" },
      -- c = {
      --   name = "Calls",
      --   i = { lspbuf.incoming_calls, "Incoming" },
      --   o = { lspbuf.outgoing_calls, "Outgoing" },
      -- },
      -- s = {
      --   d = {
      --     require("lsp.functions").view_location_split("definition", "FocusSplitNicely"),
      --     "Split Definition",
      --   },
      --   D = {
      --     require("lsp.functions").view_location_split("declaration", "FocusSplitNicely"),
      --     "Split Declaration",
      --   },
      --   r = {
      --     require("lsp.functions").view_location_split("references", "FocusSplitNicely"),
      --     "Split References",
      --   },
      --   s = {
      --     require("lsp.functions").view_location_split("implementation", "FocusSplitNicely"),
      --     "Split Implementation",
      --   },
      -- },
    },
    s = {
      name = "Search",
      [" "] = { "<cmd>Telescope resume<cr>", "Redo last" },
      -- n = { "<cmd>Telescope notify.notify<cr>", "Notifications" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      a = { "<cmd>Telescope lsp_code_actions<cr>", "Code Actions" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
      d = { "<cmd>Telescope diagnostics<cr>", "Document Diagnostics" },
      D = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
      r = { "<cmd>Telescope lsp_references<cr>", "References" },
      I = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      j = { "<cmd>Telescope jumplist<cr>", "Jump List" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      R = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      -- R = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>Telescope live_grep<cr>", "Text" },
      T = { "<cmd>Telescope live_grep_all<cr>", "Text (ALL)" },
      b = { "<cmd>Telescope curbuf<cr>", "Current Buffer" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymappings" },
      o = { "<cmd>TodoTelescope<cr>", "TODOs" },
      q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
      ["*"] = { "<cmd>Telescope grep_string<cr>", "Curr word" },
      ["/"] = { "<cmd>Telescope grep_last_search<cr>", "Last Search" },
      -- ["+"] = { "<cmd>Telescope grep_last_yank<cr>", "Last Yank" },
      -- ["."] = { [[:%s/<C-R>.//g<Left><Left>]], "Last insert" },
      i = "for (object)",
      p = { "<cmd>SearchSession<cr>", "Sessions" },
      m = { "<cmd>Telescope marks<cr>", "Marks" },
    },
    r = {
      name = "Replace/Refactor",
      -- n = { lsputil.rename, "Rename" },
      t = "Rename TS",
      ["*"] = { [["zyiw:%s/<C-R>z//g<Left><Left>]], "Curr word" },
      ["/"] = { [[:%s/<C-R>///g<Left><Left>]], "Last search" },
      ["+"] = { [[:%s/<C-R>+//g<Left><Left>]], "Last yank" },
      ["."] = { [[:%s/<C-R>.//g<Left><Left>]], "Last insert" },
      s = { [[:%s///g<Left><Left><Left>]], "From Search" },
      S = { [[:s///g<Left><Left><Left>]], "From Search" },
    },
    n = {
      name = "Generate",
      n = { "<cmd>Neogen<cr>", "Gen Doc" },
      f = { "<cmd>Neogen func<cr>", "Func Doc" },
      F = { "<cmd>Neogen file<cr>", "File Doc" },
      t = { "<cmd>Neogen type<cr>", "type Doc" },
      c = { "<cmd>Neogen class<cr>", "Class Doc" },
    },
    d = {
      name = "Diagnostics",
      i = {
        function()
          vim.b.lsp_diagnostics_hide = not vim.b.lsp_diagnostics_hide
          if vim.b.lsp_diagnostics_hide then
            vim.diagnostic.enable()
          else
            vim.diagnostic.disable()
          end
        end,
        "Toggle Inline",
      },
      l = {
        function()
          vim.diagnostic.open_float(
            0,
            vim.tbl_deep_extend(
              "keep",
              { scope = "line" },
              { header = false, border = lvim.lsp.diagnostics.float.border }
            )
          )
        end,
        "Line Diagnostics",
      },
      -- v = {
      --   -- TODO: make this not move the cursor
      --   operatorfunc_scaffold("show_diagnostics", require("lsp.functions").range_diagnostics),
      --   "Range Diagnostics",
      -- },
    },
    P = {
      name = "Projects",
    },
    -- m = "Multi",
    m = "which_key_ignore",
    -- c = {
    --   operatorfunc_keys("change_all", "<leader>c"),
    --   "Change all",
    -- },
  },
}

M.vmappings = {
  opts = {
    mode = "v", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  maps = {
    x = {
      name = "Execute/Send",
      ["<cr>"] = "Neoterm AutoMap",
      ["n"] = { "<Plug>(neoterm-repl-send)", "Neoterm Send" },
    },
  },
}
function M.whichkey(maps, opts)
  if opts == nil then
    opts = {}
  end
  require("which-key").register(maps, vim.tbl_extend("error", opts, {
    mode = "n", -- NORMAL mode
    silent = true,
    noremap = false,
    nowait = false,
  }))
end

function M.localleader(maps, opts)
  if opts == nil then
    opts = {}
  end
  opts = vim.tbl_extend("keep", opts, {
    prefix = "<localleader>",
    buffer = 0,
  })
  M.whichkey(maps, opts)
end

function M.vlocalleader(maps, opts)
  if opts == nil then
    opts = {}
  end
  M.localleader(maps, vim.tbl_extend("keep", opts, { mode = "v" }))
end

return M
