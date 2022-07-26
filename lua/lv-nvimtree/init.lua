-- if not package.loaded['nvim-tree.view'] then
--  return
-- end
local M = {}

function M.config()
  local tree_cb = require("nvim-tree.config").nvim_tree_callback

  local g = vim.g

  -- require"lv-utils".define_augroups {
  --     _nvimtree_statusline = {
  --         {
  --             "BufEnter,BufWinEnter,WinEnter,CmdwinEnter", "*",
  --             [[if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif]]
  --         }
  --     }
  -- }
  g.nvim_tree_allow_resize = 1

  require("nvim-tree").setup {
    actions = {
      open_file = {
        quit_on_open = false,
        window_picker = {
          enable = true,
        },
      },
    },
    filters = {
      custom = { ".git", "node_modules", ".cache" },
      dotfiles = true,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      highlight_git = true,
      root_folder_modifier = ":t",
      icons = {
        show = {
          git = true,
          folder = true,
          file = true,
          folder_arrow = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
          },
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
          },
        },
      },
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = true,
    open_on_tab = false,
    ignore_ft_on_setup = { "startify", "dashboard" },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    update_focused_file = { enable = true },
    view = {
      side = "left",
      width = 15,
      mappings = {
        -- g.nvim_tree_bindings = {
        --     ["u"] = ":lua require'some_module'.some_function()<cr>",
        --     ["<CR>"] = tree_cb("edit"),
        --     ["l"] = tree_cb("edit"),
        --     ["o"] = tree_cb("edit"),
        --     ["h"] = tree_cb("close_node"),
        --     ["<2-LeftMouse>"] = tree_cb("edit"),
        --     ["<2-RightMouse>"] = tree_cb("cd"),
        --     ["<C-]>"] = tree_cb("cd"),
        --     ["<C-v>"] = tree_cb("vsplit"),
        --     ["v"] = tree_cb("vsplit"),
        --     ["<C-x>"] = tree_cb("split"),
        --     ["<C-t>"] = tree_cb("tabnew"),
        --     ["<"] = tree_cb("prev_sibling"),
        --     [">"] = tree_cb("next_sibling"),
        --     ["<BS>"] = tree_cb("close_node"),
        --     ["<S-CR>"] = tree_cb("close_node"),
        --     ["<Tab>"] = tree_cb("preview"),
        --     ["I"] = tree_cb("toggle_ignored"),
        --     ["H"] = tree_cb("toggle_dotfiles"),
        --     ["R"] = tree_cb("refresh"),
        --     ["a"] = tree_cb("create"),
        --     ["d"] = tree_cb("remove"),
        --     ["r"] = tree_cb("rename"),
        --     ["<C-r>"] = tree_cb("full_rename"),
        --     ["x"] = tree_cb("cut"),
        --     ["c"] = tree_cb("copy"),
        --     ["p"] = tree_cb("paste"),
        --     ["y"] = tree_cb("copy_name"),
        --     ["Y"] = tree_cb("copy_path"),
        --     ["gy"] = tree_cb("copy_absolute_path"),
        --     ["[c"] = tree_cb("prev_git_item"),
        --     ["]c"] = tree_cb("next_git_item"),
        --     ["-"] = tree_cb("dir_up"),
        --     ["q"] = tree_cb("close")
        -- }
        list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", cb = tree_cb "close_node" },
          { key = "v", cb = tree_cb "vsplit" },
        },
      },
    },
  }
end

local view = require "nvim-tree.view"

function M.toggle_tree()
  if view.win_open() then
    require("nvim-tree").close()
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if package.loaded["bufferline.state"] then
      -- require'bufferline.state'.set_offset(31, 'File Explorer')
      require("bufferline.state").set_offset(31, "")
    end
    require("nvim-tree").find_file(true)
  end
end

return M
