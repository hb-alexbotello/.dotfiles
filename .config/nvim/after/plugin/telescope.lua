local nnoremap = require("alexbotello.keymap").nnoremap

nnoremap("<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nnoremap("<leader><leader>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nnoremap("<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")

require('telescope').load_extension('fzf')
