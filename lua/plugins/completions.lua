return {
    {
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
    {"github/copilot.vim"},
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "tpope/vim-commentary",
        config = function()
            vim.keymap.set("n", "<C-_>", ":Commentary<CR>", {})
            vim.keymap.set("v", "<C-_>", ":Commentary<CR>", {})
        end
    },
}
