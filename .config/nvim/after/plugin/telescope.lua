local nnoremap = require("alexbotello.keymap").nnoremap

nnoremap("<leader>f", "<cmd>Telescope find_files disable_devicons=true hidden=true<cr>")
nnoremap("<leader><leader>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nnoremap("<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")

require('telescope').load_extension('fzf')
