return {
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
}
