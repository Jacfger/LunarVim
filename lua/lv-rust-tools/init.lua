local M = {}
local nore = require("keymappings").nore
function M.ftplugin()
  mappings.localleader {
    ["m"] = { "<Cmd>RustExpandMacro<CR>", "Expand Macro" },
    ["H"] = { "<Cmd>RustToggleInlayHints<CR>", "Toggle Inlay Hitns" },
    ["e"] = { "<Cmd>RustRunnables<CR>", "Runnables" },
    ["h"] = { "<Cmd>RustHoverActions<CR>", "Hover Actions" },
  }
  nore("v", "gh", "<cmd>RustHoverRange<CR>", { buffer = true })
  nore("n", "gj", "<cmd>RustJoinLines<CR>", { buffer = true })

  -- require("lv-utils").define_augroups {
  --   _rust_hover_range = {
  --     { "CursorHold, CursorHoldI", "<buffer>", "RustHoverActions" },
  --   },
  -- }
end
function M.setup()
  local opts = {
    tools = { -- rust-tools options
      inlay_hints = {
        -- only_current_line = true,

        -- prefix for parameter hints
        -- default: "<-"
        parameter_hints_prefix = "❰❰ ",

        -- prefix for all the other hints (type, chaining)
        -- default: "=>"
        other_hints_prefix = ":: ",
      },

      hover_actions = {
        -- the border that is used for the hover window
        -- see vim.api.nvim_open_win()
        border = O.lsp.border,
      },
      autofocus = true,
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = require("lsp.config").conf_with {
      cmd = { DATA_PATH .. "/lspinstall/rust/rust-analyzer" },

      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            enable = true,
            command = "clippy", -- comment out to not use clippy
          },
        },
      },
    }, -- rust-analyser options
  }

  require("rust-tools").setup(opts)
end

function M.crates_setup()
  -- vim.cmd [[autocmd FileType toml lua require("lv-cmp").add_sources { { name = "crates" } }]]
  vim.cmd [[autocmd BufRead Cargo.toml lua require("lv-cmp").add_sources { { name = "crates" } }]]
end
return M
