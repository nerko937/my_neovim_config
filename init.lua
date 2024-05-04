vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.guicursor = "n-v-i-c:block-nCursor"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        "python-mode/python-mode",
        "tpope/vim-fugitive",
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme tokyonight-night]])
            end
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                local configs = require "nvim-treesitter.configs"
                configs.setup {
                    ensure_installed = {
                        "bash",
                        "html",
                        "lua",
                        "luadoc",
                        "markdown",
                        "vim",
                        "vimdoc",
                        "dockerfile",
                        "json",
                        "yaml",
                        "python",
                        "javascript",
                        "typescript"
                    },
                    highlight = {
                        enable = true
                    }
                }
            end
        },
        {
            "neovim/nvim-lspconfig",
            lazy = false,
            config = function()
                require("lspconfig").pylsp.setup {
                    settings = {
                        pylsp = {
                            plugins = {
                                pycodestyle = {ignore = {"W391", "W503"}, maxLineLength = 120}
                            }
                        }
                    }
                }
            end
        },
        {
            -- Autocompletion
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path"
            },
            config = function()
                -- `:help cmp`
                local cmp = require "cmp"
                local luasnip = require "luasnip"
                luasnip.config.setup {}
                cmp.setup {
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end
                    },
                    completion = {completeopt = "menu,menuone,noinsert"},
                    -- :help ins-completion`
                    mapping = cmp.mapping.preset.insert {
                        ["<Enter>"] = cmp.mapping.confirm {select = true},
                        ["<C-e>"] = cmp.mapping.abort()
                    },
                    sources = {
                        {name = "nvim_lsp"},
                        {name = "luasnip"},
                        {name = "path"}
                    }
                }
            end
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            config = function()
                require("lualine").setup {
                    options = {theme = "tokyonight"}
                }
            end
        },
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.6",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "BurntSushi/ripgrep",
                {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},
                {"dawsers/telescope-file-history.nvim"}
            },
            config = function()
                local telescope = require "telescope"
                telescope.setup {
                    extensions = {
                        fzf = {
                            fuzzy = true, -- false will only do exact matching
                            override_generic_sorter = true, -- override the generic sorter
                            override_file_sorter = true, -- override the file sorter
                            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                            -- the default case_mode is "smart_case"
                        }
                    }
                }
                telescope.load_extension("fzf")
                require("file_history").setup {
                    backup_dir = "~/.file-history-git",
                    git_cmd = "git"
                }
                telescope.load_extension("file_history")
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
                vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
                vim.keymap.set("n", "<leader>fh", ":Telescope file_history history<CR>", {}) --<C-r> on selected change to restore
            end
        },
        {"github/copilot.vim"},
        {"jiangmiao/auto-pairs"},
        {
            "tpope/vim-commentary",
            config = function()
                vim.keymap.set("n", "<C-_>", ":Commentary<CR>", {})
                vim.keymap.set("v", "<C-_>", ":Commentary<CR>", {})
                vim.keymap.set("i", "<C-_>", ":Commentary<CR>", {})
            end
        },
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup()
            end
        }
    }
)

