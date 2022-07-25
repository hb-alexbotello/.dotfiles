vim.opt.background = "dark"
vim.cmd("syntax on")
-- vim.cmd("colorscheme darkscene")

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_transparent = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#541e18" }
vim.g.tokyonight_colors = { hint = "#edda5f", error = "#750212" }
vim.cmd[[colorscheme tokyonight]]
