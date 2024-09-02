local nmap = require("alexbotello.keymap").nmap
local nnoremap = require("alexbotello.keymap").nnoremap
local inoremap = require("alexbotello.keymap").inoremap

-- jj will exit insert mode
inoremap("jj", "<Esc>")

-- open file tree
-- nnoremap("<c-e>", "<cmd>Ex<CR>")

nnoremap("<c-e>", "<CMD>Oil<CR>")

nmap("<leader>h", "<cmd>wincmd h<CR>")
nmap("<leader>l", "<cmd>wincmd l<CR>")
nmap("<leader>j", "<cmd>wincmd j<CR>")
nmap("<leader>k", "<cmd>wincmd k<CR>")

-- yank, delete, change will copy to clipboard register
vim.opt.clipboard:append("unnamedplus")

