local M = {}

local feedkeys = vim.api.nvim_feedkeys
local termcodes = vim.api.nvim_replace_termcodes
local t = function(k)
  return termcodes(k, true, true, true)
end

function M.dump(...)
  local objects, v = {}, nil
  for i = 1, select("#", ...) do
    v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end
function M.dump_text(...)
  local objects, v = {}, nil
  for i = 1, select("#", ...) do
    v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, "\n"), "\n")
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)
  return ...
end

function M.reload_lv_config()
  -- FIXME: Reloading config breaks things
  vim.cmd "source ~/.config/nvim/lv-config.lua"
  vim.cmd "source ~/.config/nvim/lua/plugins.lua"
  vim.cmd ":PackerCompile"
  vim.cmd ":PackerInstall"
end

function M.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function M.define_augroups(definitions) -- {{{1
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd "autocmd!"

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end
function M.define_aucmd(name, aucmd)
  M.define_augroups { [name] = { aucmd } }
end

function M.new_command(name, fn)
  vim.cmd("command! " .. name .. " " .. fn)
end

_G.lv_utils_functions = {}
local to_cmd_counter = 0
function M.to_cmd(luafunction, args)
  -- TODO: serialize opts if table
  if args == nil then
    args = ""
  end
  -- TODO: deduplicate functions?
  -- local name = "fn" .. to_cmd_counter
  to_cmd_counter = to_cmd_counter + 1
  local name = to_cmd_counter
  _G.lv_utils_functions[name] = luafunction
  return "<cmd>lua lv_utils_functions[" .. name .. "](" .. args .. ")<cr>"
end

function M.quickfix_toggle()
  if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), "v:val.quickfix")) then
    vim.cmd "copen"
  else
    vim.cmd "cclose"
  end
end
function M.conceal_toggle(n)
  if n == nil then
    n = 2
  end
  if vim.opt_local.conceallevel._value == 0 then
    vim.opt_local.conceallevel = n
  else
    vim.opt_local.conceallevel = 0
  end
end
vim.cmd [[
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* call OpenQuickFixList()
augroup END

function OpenQuickFixList()
    vert cwindow
    wincmd p
    wincmd =
endfunction
]]

function M.operatorfunc_helper_select(lines)
  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, "["))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, "]"))

  vim.fn.setpos(".", { 0, start_row, start_col + 1, 0 })
  if lines then
    vim.cmd "normal! V"
  else
    vim.cmd "normal! v"
  end
  if end_col == 1 then
    vim.fn.setpos(".", { 0, end_row - 1, -1, 0 })
  else
    vim.fn.setpos(".", { 0, end_row, end_col + 1, 0 })
  end
end

function M.post_operatorfunc(old_func)
  vim.go.operatorfunc = old_func
  _G.op_func_change_all_operator = nil
end

_G.lv_utils_operatorfuncs = {}
-- wrapper for making operators easily
function M.operatorfunc_scaffold(name, operatorfunc)
  local old_func = vim.go.operatorfunc

  _G.lv_utils_operatorfuncs[name] = function()
    operatorfunc()

    M.post_operatorfunc(old_func)
  end

  return M.to_cmd(function()
    vim.go.operatorfunc = "v:lua.lv_utils_operatorfuncs." .. name
    feedkeys("g@", "n", false)
  end)
end

-- keys linewise
function M.operatorfuncV_keys(name, verbkeys)
  return M.operatorfunc_scaffold(name, function()
    M.operatorfunc_helper_select(true)
    feedkeys(t(verbkeys), "m", false)
  end)
end

-- charwise linewise
function M.operatorfunc_keys(name, verbkeys)
  return M.operatorfunc_scaffold(name, function()
    M.operatorfunc_helper_select(false)
    feedkeys(t(verbkeys), "m", false)
  end)
end

-- the font used in graphical neovim applications
function M.set_guifont(size, font)
  if font == nil then
    font = vim.g.guifontface
  end
  vim.opt.guifont = font .. ":h" .. size
  vim.g.guifontface = font
  vim.g.guifontsize = size
end
function M.mod_guifont(diff, font)
  local size = vim.g.guifontsize
  M.set_guifont(size + diff, font)
  print(vim.opt.guifont._value)
end
vim.cmd [[
  command! FontUp lua require("lv-utils").mod_guifont(1)
  command! FontDown lua require("lv-utils").mod_guifont(-1)
]]

function M.mini_window_setwidth(initwidth)
  local wid = 0
  local cword = vim.fn.expand "<cword>"
  if #cword == 0 then
    local cline = vim.fn.getline "."
    wid = #cline + 2
  else
    wid = #cword + 1 -- + vim.o.sidescrolloff
  end
  if wid > 2 then
    if wid > initwidth then
      vim.api.nvim_win_set_width(0, wid)
    end
  end
end
function M.inline_text_input(opts)
  local enter = opts.enter
  local escape = opts.escape

  if opts.at_begin then
    vim.cmd [[normal! wb]]
  end
  if opts.init_cword then
    opts.initial = vim.fn.expand "<cword>"
  end
  if opts.initial == nil then
    opts.initial = ""
  end

  if not opts.border then
    opts.border = "none"
  end
  if opts.rel == nil then
    if opts.border == "none" then
      opts.rel = 0
    else
      opts.rel = -1
    end
  end

  local winopts = {
    relative = "cursor",
    row = opts.rel,
    col = opts.rel,
    width = #opts.initial + 1,
    height = 1,
    style = "minimal",
    -- border = O.lsp.border,
    border = opts.border,
    -- noautocmd = false
  }
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, winopts)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { opts.initial })

  if opts.minwidth then
    opts.initwidth = winopts.width
  else
    opts.initwidth = 0
  end

  local function close_win()
    feedkeys(t "<esc>", "n", false)
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })
    if escape then
      escape()
    end
  end
  local function finish_cb()
    local value = vim.trim(vim.fn.getline ".")
    close_win()
    if enter then
      enter(value)
    end
  end

  vim.opt_local.sidescrolloff = 0
  local map = vim.api.nvim_buf_set_keymap
  local fin = M.to_cmd(finish_cb)
  local cls = M.to_cmd(close_win)
  map(buf, "i", "<CR>", fin, {})
  map(buf, "n", "<CR>", fin, {})
  map(buf, "i", "<ESC>", "<NOP>", { noremap = true })
  map(buf, "i", "<ESC><ESC>", "<ESC>", { noremap = true })
  map(buf, "n", "<ESC>", cls, {})
  map(buf, "n", "o", "<nop>", { noremap = true })
  map(buf, "n", "O", "<nop>", { noremap = true })
  vim.cmd(
    string.format(
      [[autocmd InsertCharPre,InsertLeave <buffer> lua require("lv-utils").mini_window_setwidth(%d)]],
      opts.initwidth
    )
  )
end

function M.syn_group()
  local s = vim.fn.synID(vim.fn.line ".", vim.fn.col ".", 1)
  print(vim.fn.synIDattr(s, "name") .. " -> " .. vim.fn.synIDattr(vim.fn.synIDtrans(s), "name"))
end

M.cmd = setmetatable({
  lua = function(arg)
    return "<cmd>lua " .. arg .. "<cr>"
  end,
  call = function(arg)
    return "<cmd>call " .. arg .. "<cr>"
  end,
  from = M.to_cmd,
  op = M.operatorfunc_scaffold,
  require = function(name)
    local make = function(tbl, key)
      return "<cmd>lua require('" .. name .. "')." .. key .. "()<cr>"
    end
    return setmetatable({}, {
      __index = make,
      __call = make,
    })
  end,
  lsp = setmetatable({}, {
    __index = function(tbl, key)
      return "<cmd>lua vim.lsp.buf." .. key .. "()<cr>"
    end,
    __call = function(tbl, key)
      return "<cmd>lua vim.lsp.buf." .. key .. "<cr>"
    end,
  }),
  diag = setmetatable({}, {
    __index = function(tbl, key)
      return "<cmd>lua vim.lsp.diagnostic." .. key .. "()<cr>"
    end,
    __call = function(tbl, key)
      return "<cmd>lua vim.lsp.diagnostic." .. key .. "<cr>"
    end,
  }),
  telescope = setmetatable({}, {
    __index = function(tbl, key)
      return "<cmd>lua require'lv-telescope.functions'." .. key .. "()<cr>"
    end,
    __call = function(tbl, key)
      return "<cmd>lua require'lv-telescope.functions'." .. key .. "<cr>"
    end,
  }),
}, {
  __call = function(tbl, arg)
    return "<cmd>" .. arg .. "<cr>"
  end,
})

return M
