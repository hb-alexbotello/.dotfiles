local nnoremap = require("alexbotello.keymap").nnoremap

nnoremap("'f", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
nnoremap("'d", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
nnoremap("'s", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
nnoremap("'a", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
nnoremap("<leader>m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
nnoremap("m", "<cmd>lua require('harpoon.mark').add_file()<cr>")

-- require("harpoon").setup()
require("harpoon").setup({
    global_settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = false,

        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,

        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = false,

        -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,

        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { "harpoon" },

        -- set marks specific to each git branch inside git repository
        mark_branch = true,
    }
})

