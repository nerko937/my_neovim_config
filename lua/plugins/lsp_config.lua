return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            require("lspconfig").pylsp.setup {
                on_attach = function(client)
                    vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
                    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
                end,
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
}
