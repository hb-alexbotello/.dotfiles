require("tokyonight").setup({
  -- use the night style
  style = "storm",
  -- disable italic for functions
  styles = {
    functions = "NONE" 
  },
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true,
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = "#edda5f"
    colors.error = "#750212"
  end
})

vim.cmd[[colorscheme tokyonight]]
