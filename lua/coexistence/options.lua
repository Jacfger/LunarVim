vim.opt.autowriteall = true

local M = {}
M.tsoptions = {
  textobj_prefixes = {
    -- goto_next = "]", -- Go to next
    -- goto_next = "'", -- Go to next
    goto_next = "]", -- Go to next
    goto_previous = "[", -- Go to previous
    -- goto_next = "<leader>n", -- Select next
    -- goto_previous = "<leader>p", -- Select previous
    inner = "i", -- Select inside
    outer = "a", -- Selct around
    -- swap = '<leader>a'
    swap_next = ")", -- Swap with next
    swap_prev = "(", -- Swap with previous
  },
  textobj_suffixes = {
    -- Start and End respectively for the goto keys
    -- Outer and Inner for the select_{next,prev} keys
    -- for other keys it only uses the first
    ["function"] = { "f", "F" },
    ["class"] = { "m", "M" },
    ["parameter"] = { "a", "A" },
    ["block"] = { "k", "K" },
    ["conditional"] = { "i", "I" },
    ["call"] = { "c", "C" },
    ["loop"] = { "r", "R" },
    ["statement"] = { "l", "L" },
    ["comment"] = { "/", "?" },
  },
  other_suffixes = { -- FIXME: Unused
    ["scope"] = { "S", "s" },
    ["element"] = { "e", "E" },
    ["subject"] = { "z", "Z" },
  },
}

return M
