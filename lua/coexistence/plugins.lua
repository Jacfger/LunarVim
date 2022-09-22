local plugins = {
  {
    "windwp/nvim-spectre",
    module = "spectre",
    config = function()
      require("coexistence.extra.spectre").setup()
    end,
  },
  { "rmagatti/auto-session" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
}

return plugins
