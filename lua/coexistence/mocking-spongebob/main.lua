require("nvim-treesitter.parsers").get_buf_lang()
local namespace = vim.api.nvim_create_namespace('mocking-spongebob')
function Draw_text()
  local bnr = vim.fn.bufnr('%')

  local line_num = 5
  local col_num = 5

  local opts = {
    end_line = 10,
    id = 1,
    virt_text = { { "demo", "IncSearch" } },
    virt_text_pos = 'overlay',
    -- virt_text_win_col = 20,
  }
  --
  print(require('nvim-treesitter.ts_utils').get_node_at_cursor())
  -- local mark_id = vim.api.nvim_buf_set_extmark(0, namespace, line_num, col_num, opts) -- test
  -- print(mark_id)
end

return {
  draw = Draw_text
}
