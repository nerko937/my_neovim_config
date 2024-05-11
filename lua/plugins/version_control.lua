return {
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup{
                on_attach = function(client)
                    vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', {})
                    vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', {})
                    vim.keymap.set('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', {})
                end,
            }
        end
    },
}
