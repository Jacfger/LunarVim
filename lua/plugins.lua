local execute = vim.api.nvim_command
local fn = vim.fn


local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then vim.cmd("packadd " .. plugin) end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
-- vim.cmd "autocmd BufWritePost lv-config.lua PackerCompile" -- Auto compile when there are changes in plugins.lua
vim.cmd "autocmd BufWritePost plugins.lua luafile %" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use "wbthomason/packer.nvim"

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {"neovim/nvim-lspconfig"}
    use {"glepnir/lspsaga.nvim"}
    use {"kabouzeid/nvim-lspinstall"}
    -- Telescope
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope.nvim"}

    -- Autocomplete
    use {
        "hrsh7th/nvim-compe",
        config = function()
            require("lv-compe").config()
        end,
        event = "InsertEnter"
    }

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    use {
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = function()
            require("lv-nvimtree").config()
        end

    }

    -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
    use {
        "lewis6991/gitsigns.nvim",

        config = function()
            require("lv-gitsigns").config()
        end,
        event = "BufRead"
    }

    use {"folke/which-key.nvim"}
    use {"windwp/nvim-autopairs"}

    -- Comments
    use {
        "terrortylor/nvim-comment",
        cmd = "CommentToggle",
        config = function()
            require('nvim_comment').setup()
        end
    }

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

    -- Icons
    use {"kyazdani42/nvim-web-devicons"}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim"}

    use {
        "romgrk/barbar.nvim",

        config = function()
            vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>',
                                    {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>',
                                    {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<S-x>', ':BufferClose<CR>',
                                    {noremap = true, silent = true})
        end

    }

    use {"hrsh7th/vim-vsnip"}
    use {
        event = 'BufRead',
        'phaazon/hop.nvim',
        config = function()
            require('lv-hop').config()
        end,
        disable = not O.plugins.hop.active,
        opt = true
    }

    -- extras
    -- if O.matchup then require('lv-matchup') end
    --     require('lv-rnvimr')
    --     require('lv-gitblame')
    --     require('lv-numb')
    --     require('lv-dial')
    --     require('lv-hop')
    --     require('lv-colorizer')
    --     require('lv-spectre')
    --     require('lv-symbols-outline')
    --     require('lv-vimtex')
    --     require('lv-zen')
    --     require('lv-dashboard')
    --     require('lv-lsp-rooter')
    -- end

    -- Extras
    if O.extras then
        -- Interactive scratchpad
        use {'metakirby5/codi.vim', opt = true}
        require_plugin('codi.vim')
        -- Markdown preview
        use {
            'iamcco/markdown-preview.nvim',
            run = 'cd app && npm install',
            opt = true
        }
        require_plugin('markdown-preview.nvim')
        -- Floating terminal
        use {'numToStr/FTerm.nvim', opt = true}
        require_plugin('FTerm.nvim')
        -- Enhanced increment/decrement
        use {'monaqa/dial.nvim', opt = true}
        require_plugin('dial.nvim')
        -- Peek lines
        use {'nacro90/numb.nvim', opt = true}
        require_plugin('numb.nvim')
        -- HTML preview
        use {
            'turbio/bracey.vim',
            run = 'npm install --prefix server',
            opt = true
        }
        require_plugin('bracey.vim')
        -- Better motions
        use {'phaazon/hop.nvim', opt = true}
        require_plugin('hop.nvim')
        -- Colorizer
        use {'norcalli/nvim-colorizer.lua', opt = true}
        require_plugin('nvim-colorizer.lua')
        -- Search & Replace
        use {'windwp/nvim-spectre', opt = true}
        require_plugin('nvim-spectre')
        use {'simrat39/symbols-outline.nvim', opt = true}
        require_plugin('symbols-outline.nvim')
        -- Treesitter playground
        use {'nvim-treesitter/playground', opt = true}
        require_plugin('playground')
        -- Latex
        use {"lervag/vimtex", opt = true}
        require_plugin("vimtex")
        -- matchup
        use {'andymass/vim-matchup', opt = true}
        require_plugin('vim-matchup')
        -- comments in context
        use {'JoosepAlviste/nvim-ts-context-commentstring', opt = true}
        require_plugin("nvim-ts-context-commentstring")
        -- Zen Mode
        use {"Pocco81/TrueZen.nvim", opt = true}
        require_plugin("TrueZen.nvim")
        -- Git extras
        use {'f-person/git-blame.nvim', opt = true}
        require_plugin("git-blame.nvim")
        -- TODO remove when open on dir is supported by nvimtree
        --  use "kevinhwang91/rnvimr"
        use {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
        use {"nvim-telescope/telescope-project.nvim", opt = true}
        require_plugin('telescope-project.nvim')

        -- Debugging
        use {"mfussenegger/nvim-dap", opt = true}
        require_plugin("nvim-dap")

        use {"rafamadriz/friendly-snippets", opt = true}
        require_plugin("friendly-snippets")

        use {"kevinhwang91/nvim-bqf", opt = true}
        require_plugin("nvim-bqf")

        use {"ahmedkhalf/lsp-rooter.nvim", opt = true} -- with this nvim-tree will follow you
        require_plugin('lsp-rooter.nvim')

        use {"ChristianChiarulli/dashboard-nvim", opt = true}
        require_plugin("dashboard-nvim")

        use {"folke/trouble.nvim", opt = true}
        require_plugin('trouble.nvim')

        -- Sane gx for netrw_gx bug
        use {"felipec/vim-sanegx", opt = true}
        -- Autotag
        -- use {"windwp/nvim-ts-autotag", opt = true}
        -- require_plugin("nvim-ts-autotag")

        -- folke/todo-comments.nvim
        -- gennaro-tedesco/nvim-jqx
        -- TimUntersberger/neogit
        -- folke/lsp-colors.nvim
        -- simrat39/symbols-outline.nvim

        -- Git
        -- use {'tpope/vim-fugitive', opt = true}
        -- use {'tpope/vim-rhubarb', opt = true}
        -- pwntester/octo.nvim

        -- Easily Create Gists
        -- use {'mattn/vim-gist', opt = true}
        -- use {'mattn/webapi-vim', opt = true}
    end

    -- amedhi plugins
    use {"unblevable/quick-scope", opt = true}
    use {"justinmk/vim-sneak", opt = true}
    use {"wellle/targets.vim", opt = true}
    use {"mg979/vim-visual-multi", opt = true}
    use {"dag/vim-fish", opt = true}
    use {"tpope/vim-surround", opt = true}
    use {"junegunn/fzf", opt = true} -- Telescope does most of this?
    use {"junegunn/fzf.vim", opt = true}
    use {"skywind3000/asyncrun.vim", opt = true}
    use {"Shatur95/neovim-cmake", opt = true}
    use 'karb94/neoscroll.nvim'
    use "folke/todo-comments.nvim"
    use 'sindrets/diffview.nvim'
    use {'voldikss/vim-floaterm', opt = true}
    use {"SirVer/ultisnips", opt = true}
    use {"jpalardy/vim-slime", opt = true}
    -- https://github.com/tpope/vim-repeat
    use {"kmonad/kmonad-vim", opt=true}
    use {"lambdalisue/suda.vim", opt=true}
    use "NoahTheDuke/vim-just"

    -- lsp extensions
    use {"nvim-lua/lsp_extensions.nvim", opt = true}
    use {"nvim-lua/completion-nvim", opt = true}
    use {"liuchengxu/vista.vim", opt = true}
    use "ray-x/lsp_signature.nvim"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "RRethy/nvim-treesitter-textsubjects"

    require_plugin("ultisnips")
    require_plugin("vim-slime")
    require_plugin("vim-floaterm")
    require_plugin("asyncrun.vim")
    require_plugin("neovim-cmake")
    require_plugin("fzf")
    require_plugin("fzf.vim")
    require_plugin("vista.vim")
    require_plugin("vim-surround")
    require_plugin("lsp_extensions.nvim")
    require_plugin("completion-nvim")
    require_plugin("targets.vim")
    require_plugin("quick-scope")
    require_plugin("vim-fish")
    require_plugin("vim-visual-multi")
    require_plugin("vim-sneak")
    require_plugin("nvim-treesitter-textobjects")
    require_plugin("kmonad-vim")
    require_plugin("suda.vim")

    -- Colorschemes
    -- use {'Mofiqul/dracula.nvim', opt=true}
    -- use {'tomasiser/vim-code-dark', opt=true}
    -- require_plugin("Mofiqul/dracula.nvim")
    -- require_plugin("tomasiser/vim-code-dark")

end)
