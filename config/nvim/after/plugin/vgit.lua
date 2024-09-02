local nmap = require("alexbotello.keymap").nmap

nmap("<leader>g", "<cmd>VGit buffer_gutter_blame_preview<CR>")
vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'

require('vgit').setup()
