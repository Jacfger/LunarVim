local M = {}
vim.keymap.set("x", ";", ":", {})
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("n", ">", ">>", { nowait = true })
vim.keymap.set("n", "<", "<<", { nowait = true })
vim.keymap.set("n", "<ESC>", "<cmd>nohls<cr>", {})


-- Preserve register on pasting in visual mode
-- TODO: use the correct register
vim.keymap.set("x", "p", "pgvy", {})
vim.keymap.set("x", "P", "p", {}) -- for normal p behaviour
vim.keymap.set("x", "<M-p>", "pgv", {}) -- Paste and keep selection

-- Preserve cursor on yank in visual mode
-- TODO: use register argument
vim.keymap.set("x", "y", "myy`y", {})
vim.keymap.set("x", "Y", "myY`y", {}) -- copy linewise
vim.keymap.set("x", "<M-y>", "y", {})


-- Select whole file
vim.keymap.set("o", "iG", "<cmd>normal! mzggVG<cr>`z", { noremap = true, silent = true })
vim.keymap.set("x", "iG", "gg0oG$", { noremap = true, silent = true })
vim.keymap.set("o", "iG", "<cmd>normal vgg0oG$<cr>", { noremap = true, silent = true })

-- Make change line (cc) preserve indentation
vim.keymap.set("n", "cc", "^cg_", { noremap = true, silent = true })

-- Set local leader
vim.g.maplocalleader = ","

-- Add meta version that doesn't affect the clipboard
local function dont_clobber_if_meta(m, c)
  if string.upper(c) == c then
    vim.keymap.set(m, "<M-S-" .. string.lower(c) .. ">", '"_' .. c, {})
  else
    vim.keymap.set(m, "<M-" .. c .. ">", '"_' .. c, {})
  end
end

-- Make the default not touch the clipboard, and add a meta version that does
local function dont_clobber_by_default(m, c)
  if string.upper(c) == c then
    vim.keymap.set(m, "<M-S-" .. string.lower(c) .. ">", c, {})
  else
    vim.keymap.set(m, "<M-" .. c .. ">", c, {})
  end
  vim.keymap.set(m, c, '"_' .. c, {})
end

dont_clobber_if_meta("n", "d")
dont_clobber_if_meta("n", "D")
dont_clobber_if_meta("x", "r")
dont_clobber_by_default("n", "c")
dont_clobber_by_default("x", "c")
dont_clobber_by_default("n", "C")
dont_clobber_by_default("n", "x")
dont_clobber_by_default("x", "x")

local whichkey = require("which-key")
local mappings = require('coexistence.which-key-mapping').mappings
whichkey.register(mappings.maps, mappings.opts)
local vmappings = require('coexistence.which-key-mapping').vmappings
whichkey.register(vmappings.maps, vmappings.opts)
-- require("which-key").register(mappings.maps, mappings.opts)

-- local map = vim.keymap.set
-- vim.cmd [[ command -nargs=+ Tmem :lua require("lv-terms").Tmem("<args>") ]]

-- vim.g.neoterm_automap_keys = "<leader>x<cr>"


return M
