local M = {}

-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
local last_echo = { false, -1, -1 }
-- The timer used for displaying a diagnostic in the commandline.
local echo_timer = nil
-- The timer after which to display a diagnostic in the commandline.
local echo_timeout = 30
-- The highlight group to use for warning messages.
local warning_hlgroup = "WarningMsg"
-- The highlight group to use for error messages.
local error_hlgroup = "ErrorMsg"
-- If the first diagnostic line has fewer than this many characters, also add
-- the second line to it.
local short_line_limit = 20

-- Prints the first diagnostic for the current line.
-- Bind to CursorMoved to update live: vim.cmd [[autocmd CursorMoved * :lua require("lsp.functions").echo_diagnostic()]]
M.echo_diagnostic = function()
  if echo_timer then
    echo_timer:stop()
  end

  echo_timer = vim.defer_fn(function()
    local line = vim.fn.line "." - 1
    local bufnr = vim.api.nvim_win_get_buf(0)

    if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
      return
    end

    local diags = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line, { severity_limit = "Warning" })

    if #diags == 0 then
      -- If we previously echo'd a message, clear it out by echoing an empty
      -- message.
      if last_echo[1] then
        last_echo = { false, -1, -1 }

        vim.api.nvim_command 'echo ""'
      end

      return
    end

    last_echo = { true, bufnr, line }

    local diag = diags[1]
    local width = vim.api.nvim_get_option "columns" - 15
    local lines = vim.split(diag.message, "\n")
    local message = lines[1]
    local lineindex = 2

    if width == 0 then
      if #lines > 1 and #message <= short_line_limit then
        message = message .. " " .. lines[lineindex]
      end
    else
      while #message < width do
        message = message .. " " .. lines[lineindex]
        lineindex = lineindex + 1
      end
    end

    if width > 0 and #message >= width then
      message = message:sub(1, width) .. "..."
    end

    local kind = "warning"
    local hlgroup = warning_hlgroup

    if diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
      kind = "error"
      hlgroup = error_hlgroup
    end

    local chunks = {
      { kind .. ": ", hlgroup },
      { message },
    }

    vim.api.nvim_echo(chunks, false, {})
  end, echo_timeout)
end
M.simple_echo_diagnostic = function()
  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
  if vim.tbl_isempty(line_diagnostics) then
    vim.cmd [[echo ""]]
    return
  end
  for i, diagnostic in ipairs(line_diagnostics) do
    vim.cmd("echo '" .. diagnostic.message .. "'")
  end
end

-- Format a range using LSP
M.format_range_operator = function()
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local start = vim.api.nvim_buf_get_mark(0, "[")
    local finish = vim.api.nvim_buf_get_mark(0, "]")
    vim.lsp.buf.range_formatting({}, start, finish)
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = "v:lua.op_func_formatting"
  vim.api.nvim_feedkeys("g@", "n", false)
end

-- Preview definitions and things
local function preview_location_callback(_, _, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1], {
    border = O.lsp.border,
  })
end

M.preview_location_at = function(name)
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/" .. name, params, preview_location_callback)
end

M.toggle_diagnostics = function()
  vim.b.lsp_diagnostics_hide = not vim.b.lsp_diagnostics_hide
  if vim.b.lsp_diagnostics_hide then
    vim.lsp.diagnostic.enable()
  else
    vim.lsp.diagnostic.disable()
  end
end

-- TODO: Implement codeLens handlers
M.show_codelens = function()
  -- vim.cmd [[ autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh() ]]
  -- vim.api.nvim_exec(
  --   [[
  --   augroup lsp_codelens_refresh
  --     autocmd! * <buffer>
  --     autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
  --   augroup END
  --   ]],
  --   false
  -- )

  local clients = vim.lsp.buf_get_clients(0)
  for k, v in pairs(clients) do
    vim.lsp.codelens.display(vim.lsp.codelens.get(0, k), 0, k, O.lsp.codeLens)
    -- vim.lsp.codelens.display(nil, 0, k, O.lsp.codeLens)
  end
end

-- TODO: what is this?
-- vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'

-- Jump between diagnostics
local popup_diagnostics_opts = {
  show_header = false,
  border = O.lsp.border,
}
M.diag_line = function()
  vim.lsp.diagnostic.show_line_diagnostics(popup_diagnostics_opts)
end
M.diag_cursor = function()
  vim.lsp.diagnostic.show_cursor_diagnostics(popup_diagnostics_opts)
end
M.diag_next = function()
  vim.lsp.diagnostic.goto_next { popup_opts = popup_diagnostics_opts }
end
M.diag_prev = function()
  vim.lsp.diagnostic.goto_prev { popup_opts = popup_diagnostics_opts }
end

M.common_on_attach = function(client, bufnr)
  -- Handle document highlighting
  if O.lsp.document_highlight then
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec(
        [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]],
        false
      )
    end
  end

  if O.lsp.live_codelens then
    if client.resolved_capabilities.code_lens then
      vim.api.nvim_exec(
        [[
        augroup lsp_codelens_refresh
          autocmd! * <buffer>
          autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
        augroup END
        ]],
        false
      )
    end
  end

  if O.lsp.autoecho_line_diagnostics then
    -- if client.resolved_capabilities.document_highlight then
    -- autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()
    vim.api.nvim_exec(
      [[ augroup lsp_au
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua require("lsp.functions").echo_diagnostic()
      augroup END ]],
      false
    )
    -- end
  end
end

-- Helper for better renaming interface
M.rename = function()
  require("lv-utils").inline_text_input {
    border = O.lsp.rename_border,
    enter = vim.lsp.buf.rename,
    init_cword = true,
    at_begin = true,
  }
end

return M
