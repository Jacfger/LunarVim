local M = {}


function M.setup()
  -- ft = spectre_panel
  -- TODO: register which-key

  require("spectre").setup {
    find_engine = {
      -- rg is map with finder_cmd
      ["rg"] = {
        cmd = "rg",
        -- default args
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--no-config",
        },
        options = {
          ["ignore-case"] = {
            value = "--ignore-case",
            icon = "[I]",
            desc = "ignore case",
          },
          ["hidden"] = {
            value = "--hidden",
            desc = "hidden file",
            icon = "[H]",
          },
          ["multiline"] = {
            value = "--multiline",
            desc = "multiline search",
            icon = "[M]",
          },
          -- you can put any option you want here it can toggle with
          -- show_option function
        },
      },
    },
    mapping = maps,
    live_update = true,
  }
end

return M
