return {
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
}
