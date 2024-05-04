return {
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
}
