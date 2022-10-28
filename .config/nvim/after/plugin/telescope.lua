local nnoremap = require("alexbotello.keymap").nnoremap

-- Space + f = open Fuzzy File Finder
nnoremap("<leader>f", "<cmd>Telescope find_files disable_devicons=true hidden=true<cr>")

-- Space + Space = open project search
nnoremap("<leader><leader>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")

-- Space + b = open Buffers list
nnoremap("<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")

-- Space + m = open Marks list
-- nnoremap("<leader>m", "<cmd>Telescope harpoon marks<cr>")

require('telescope').load_extension('fzf')
-- require('telescope').load_extension('harpoon')
