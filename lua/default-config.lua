CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"

local enable_plugins_by_default = true
local enable_autofmt_by_default = false -- this is the lsp autoformat
-- TODO: switch between neoformat and lsp autoformat smartly

local diagnostics = {
  virtual_text = { spacing = 0, prefix = "" },
  signs = true,
  underline = true,
}
local lsp_border = "single"

O = {
  auto_close_tree = 0,
  auto_complete = true,
  colorscheme = "lunar",
  hidden_files = true,
  wrap_lines = false,
  number = true,
  relative_number = true,
  cursorline = true,
  shell = "bash",
  timeoutlen = 100,
  nvim_tree_disable_netrw = 0,
  ignore_case = true,
  smart_case = true,
  scrolloff = 0,
  lushmode = false,
  hl_search = false,
  transparent_window = false,
  leader_key = "space",
  vnsip_dir = CONFIG_PATH .. "/snippets",
  breakpoint_sign = { text = "🛑", texthl = "", linehl = "", numhl = "" },
  lsp = { border = lsp_border },

  hint_labels = { "h", "j", "f", "d", "n", "v", "s", "l", "a" },

  -- @usage pass a table with your desired languages
  treesitter = {
    ensure_installed = "all",
    ignore_install = { "haskell" },
    enable = true,
  },

  database = { save_location = "~/.config/nvim/.db", auto_execute = 1 },

  plugin = {
    hop = { active = enable_plugins_by_default },
    dial = { active = enable_plugins_by_default },
    dashboard = { active = enable_plugins_by_default },
    matchup = { active = enable_plugins_by_default },
    colorizer = { active = enable_plugins_by_default },
    numb = { active = enable_plugins_by_default },
    zen = { active = enable_plugins_by_default },
    ts_playground = { active = enable_plugins_by_default },
    ts_context_commentstring = { active = enable_plugins_by_default },
    ts_textobjects = { active = enable_plugins_by_default },
    ts_autotag = { active = enable_plugins_by_default },
    ts_textsubjects = { active = enable_plugins_by_default },
    ts_rainbow = { active = enable_plugins_by_default },
    ts_context = { active = enable_plugins_by_default },
    ts_hintobjects = { active = enable_plugins_by_default },
    indent_line = { active = enable_plugins_by_default },
    symbol_outline = { active = enable_plugins_by_default },
    debug = { active = enable_plugins_by_default },
    bqf = { active = enable_plugins_by_default },
    trouble = { active = enable_plugins_by_default },
    floatterm = { active = enable_plugins_by_default },
    spectre = { active = enable_plugins_by_default },
    lsp_rooter = { active = enable_plugins_by_default },
    markdown_preview = { active = enable_plugins_by_default },
    codi = { active = enable_plugins_by_default },
    telescope_fzy = { active = enable_plugins_by_default },
    sanegx = { active = enable_plugins_by_default },
    snap = { active = enable_plugins_by_default },
    ranger = { active = enable_plugins_by_default },
    todo_comments = { active = enable_plugins_by_default },
    lsp_colors = { active = enable_plugins_by_default },
    lsp_signature = {
      active = enable_plugins_by_default,
      doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);                      -- Apply indentation for wrapped lines
      use_lspsaga = false, -- set to true if you want to use lspsaga popup
      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
      fix_pos = true, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ", -- Panda for parameter
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    },
    git_blame = { active = enable_plugins_by_default },
    gitlinker = { active = enable_plugins_by_default },
    lazygit = { active = enable_plugins_by_default },
    octo = { active = enable_plugins_by_default },
    lush = { active = enable_plugins_by_default },
    diffview = { active = enable_plugins_by_default },
    bracey = { active = enable_plugins_by_default },
    telescope_project = { active = enable_plugins_by_default },
    gist = { active = enable_plugins_by_default },
    dap_install = { active = enable_plugins_by_default },
    visual_multi = { active = enable_plugins_by_default },
    sneak = { active = enable_plugins_by_default }, -- Uses lightspeed.nvim
    quickscope = { active = enable_plugins_by_default },
    surround = { active = enable_plugins_by_default }, -- Uses vim-sandwhich
    fzf = { active = enable_plugins_by_default },
    slime = { active = enable_plugins_by_default },
    bullets = { active = enable_plugins_by_default },
    vista = { active = enable_plugins_by_default },
    startuptime = { active = enable_plugins_by_default },
    tabnine = { active = enable_plugins_by_default },
    tmux_navigator = { active = enable_plugins_by_default },
    flutter_tools = { active = enable_plugins_by_default },
    editorconfig = { active = enable_plugins_by_default },
  },

  lang = {
    python = {
      linter = "",
      -- @usage can be 'yapf', 'black'
      formatter = "",
      autoformat = enable_autofmt_by_default,
      isort = false,
      diagnostics = diagnostics,
      analysis = {
        type_checking = "basic",
        auto_search_paths = true,
        use_library_code_types = true,
      },
    },
    dart = {
      autoformat = enable_autofmt_by_default,
      sdk_path = "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
    },
    lua = {
      -- @usage can be 'lua-format'
      formatter = "",
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    sh = {
      -- @usage can be 'shellcheck'
      linter = "",
      -- @usage can be 'shfmt'
      formatter = "",
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    tsserver = {
      -- @usage can be 'eslint'
      linter = "",
      -- @usage can be 'prettier'
      formatter = "",
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    json = {
      -- @usage can be 'prettier'
      formatter = "",
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    tailwindcss = {
      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
    },
    clang = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
      cross_file_rename = true,
      header_insertion = "never",
    },
    ruby = {
      diagnostics = diagnostics,
      filetypes = { "rb", "erb", "rakefile", "ruby" },
    },
    go = { autoformat = enable_autofmt_by_default },
    elixir = { autoformat = enable_autofmt_by_default },
    vim = { autoformat = enable_autofmt_by_default },
    yaml = { autoformat = enable_autofmt_by_default },
    terraform = { autoformat = enable_autofmt_by_default },
    rust = {
      rust_tools = { active = false },
      autoformat = enable_autofmt_by_default,
      linter = "",
      formatter = "",
      diagnostics = diagnostics,
    },
    svelte = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    php = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
      format = { braces = "psr12" },
      environment = { php_version = "7.4" },
      filetypes = { "php", "phtml" },
    },
    latex = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
      filetypes = { "tex", "bib" },
      aux_directory = ".",
      bibtex_formatter = "texlab",
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forward_search_after = false,
        on_save = false,
      },
      chktex = { on_edit = false, on_open_and_save = false },
      diagnostics_delay = vim.opt.updatetime,
      formatter_line_length = 80,
      forward_search = { args = {}, executable = "" },
      latex_formatter = "latexindent",
      latexindent = { modify_line_breaks = false },
    },
    kotlin = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    html = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    elm = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    emmet = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
      active = false,
    },
    graphql = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    efm = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    docker = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    cmake = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    java = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    zig = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
    julia = {
      autoformat = enable_autofmt_by_default,
      diagnostics = diagnostics,
    },
  },

  dashboard = {

    custom_header = {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣶⣾⠿⠿⠟⠛⠛⠛⠛⠿⠿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⡿⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠒⠂⠉⠉⠉⠉⢩⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⠀⢰⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠠⡀⠀⠀⢀⣾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⢀⣸⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡧⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠈⠁⠒⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⠉⠢⠤⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡟⠈⠑⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠑⠒⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⡇⠀⠀⢀⣣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠒⠢⠤⠄⣀⣀⠀⠀⠀⢠⣿⡟⠀⠀⠀⣺⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠇⠀⠀⠀⠀⠀⣤⡄⠀⠀⢠⣤⡄⠀⢨⣭⣠⣤⣤⣤⡀⠀⠀⢀⣤⣤⣤⣤⡄⠀⠀⠀⣤⣄⣤⣤⣤⠀⠀⣿⣯⠉⠉⣿⡟⠀⠈⢩⣭⣤⣤⠀⠀⠀⠀⣠⣤⣤⣤⣄⣤⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⣸⣿⠁⠀⣿⣿⠉⠀⠈⣿⡇⠀⠀⠛⠋⠀⠀⢹⣿⠀⠀⠀⣿⠏⠀⠸⠿⠃⠀⣿⣿⠀⣰⡟⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⣿⡟⢸⣿⡇⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⣿⡟⠀⢠⣿⡇⠀⠀⢰⣿⡇⠀⣰⣾⠟⠛⠛⣻⡇⠀⠀⢸⡿⠀⠀⠀⠀⠀⠀⢻⣿⢰⣿⠀⠀⠀⠀⠀⠀⣾⡇⠀⠀⠀⢸⣿⠇⢸⣿⠀⢸⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣧⣤⣤⣤⡄⠀⠘⣿⣤⣤⡤⣿⠇⠀⢸⣿⠁⠀⠀⣼⣿⠀⠀⢿⣿⣤⣤⠔⣿⠃⠀⠀⣾⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⠋⠀⠀⠀⢠⣤⣤⣿⣥⣤⡄⠀⣼⣿⠀⣸⡏⠀⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠁⠀⠀⠈⠉⠉⠀⠉⠀⠀⠈⠉⠀⠀⠀⠉⠉⠀⠀⠀⠉⠉⠁⠈⠉⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠁⠀⠉⠁⠀⠉⠁⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    },
    footer = { "chrisatmachine.com" },
  },
}

vim.cmd('let &titleold="' .. TERMINAL .. '"')

-- TODO find a new home for these autocommands
require("lv-utils").define_augroups {
  _general_settings = {
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    {
      "BufWinEnter",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufRead",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufNewFile",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    { "VimLeavePre", "*", "set title set titleold=" },
    { "FileType", "qf", "set nobuflisted" },
  },
  -- _solidity = {
  --     {'BufWinEnter', '.sol', 'setlocal filetype=solidity'}, {'BufRead', '*.sol', 'setlocal filetype=solidity'},
  --     {'BufNewFile', '*.sol', 'setlocal filetype=solidity'}
  -- },
  -- _gemini = {
  --     {'BufWinEnter', '.gmi', 'setlocal filetype=markdown'}, {'BufRead', '*.gmi', 'setlocal filetype=markdown'},
  --     {'BufNewFile', '*.gmi', 'setlocal filetype=markdown'}
  -- },
  -- _latex = {
  --     {'FileType', 'latex', 'VimtexCompile'},
  --     {'FileType', 'latex', 'setlocal wrap'},
  --     {'FileType', 'latex', 'setlocal spell'}
  --     -- {'FileType', 'latex', 'set guifont "FiraCode Nerd Font:h15'},
  -- },
  _packer_compile = { { "User", "PackerComplete", "++once PackerCompile" } },
  _buffer_bindings = {
    { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
    { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
    { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
    {
      "FileType",
      "rnvimr",
      "tnoremap <silent> <buffer> <nowait> - <ESC>:q<CR>",
    },
    {
      "FileType",
      "rnvimr",
      "inoremap <silent> <buffer> <nowait> - <ESC>:q<CR>",
    },
  },
  _terminal_insert = {
    { "BufEnter", "*", [[if &buftype == 'terminal' | :startinsert | endif]] },
  },
  _auto_reload = {
    -- will check for external file changes on cursor hold
    { "CursorHold", "*", "silent! checktime" },
  },
  _auto_resize = {
    -- will cause split windows to be resized evenly if main window is resized
    { "VimResized ", "*", "wincmd =" },
  },
  _mode_switching = {
    -- will switch between absolute and relative line numbers depending on mode
    { "InsertEnter", "*", "setlocal number norelativenumber nocursorline" },
    { "InsertLeave ", "*", "setlocal relativenumber cursorline" },
    { "WinEnter", "*", "setlocal cursorline" },
    { "WinLeave", "*", "setlocal nocursorline" },
  },
  _neoformat = {
    {
      "BufWritePre",
      "*",
      [[try | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry]],
    },
  },
}
