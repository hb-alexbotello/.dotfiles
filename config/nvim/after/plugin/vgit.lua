local nmap = require("alexbotello.keymap").nmap

nmap("<leader>g", "<cmd>VGit buffer_gutter_blame_preview<CR>")
vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'

require('vgit').setup({
  settings = {
    hls = {
      GitSignsAdd = {
        gui = nil,
        fg = '#d7ffaf',
        bg = nil, -- Transparent background
        sp = nil,
        override = true, -- Ensure the highlight is applied
      },
      GitSignsChange = {
        gui = nil,
        fg = '#7AA6DA',
        bg = nil, -- Transparent background
        sp = nil,
        override = true, -- Ensure the highlight is applied
      },
      GitSignsDelete = {
        gui = nil,
        fg = '#e95678',
        bg = nil, -- Transparent background
        sp = nil,
        override = true, -- Ensure the highlight is applied
      },
    },
  },
})
