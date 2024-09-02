 -- require('nightfox').setup({
 --   options = {
 --     -- Compiled file's destination location
 --     compile_path = vim.fn.stdpath("cache") .. "/nightfox",
 --     compile_file_suffix = "_compiled", -- Compiled file suffix
 --     transparent = true,     -- Disable setting background
 --     terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
 --     dim_inactive = false,    -- Non focused panes set to alternative background
 --     module_default = true,   -- Default enable value for modules
 --     colorblind = {
 --       enable = false,        -- Enable colorblind support
 --       simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
 --       severity = {
 --         protan = 0,          -- Severity [0,1] for protan (red)
 --         deutan = 0,          -- Severity [0,1] for deutan (green)
 --         tritan = 0,          -- Severity [0,1] for tritan (blue)
 --       },
 --     },
 --     styles = {               -- Style to be applied to different syntax groups
 --       comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
 --       conditionals = "NONE",
 --       constants = "NONE",
 --       functions = "NONE",
 --       keywords = "NONE",
 --       numbers = "NONE",
 --       operators = "NONE",
 --       strings = "NONE",
 --       types = "NONE",
 --       variables = "NONE",
 --     },
 --     inverse = {             -- Inverse highlight for different types
 --       match_paren = false,
 --       visual = false,
 --       search = false,
 --     },
 --     modules = {             -- List of various plugins and additional options
 --       -- ...
 --     },
 --   },
 --   palettes = {},
 --   specs = {},
 --   groups = {},
 -- })

-- vim.cmd("colorscheme nightfox")

local palette = require 'nordic.colors'
require 'nordic' .setup {
    -- This callback can be used to override the colors used in the palette.
    on_palette = function(palette) return palette end,
    -- Enable bold keywords.
    bold_keywords = false,
    -- Enable italic comments.
    italic_comments = false,
    -- Enable general editor background transparency.
    transparent_bg = true,
    -- Enable brighter float border.
    bright_border = false,
    -- Reduce the overall amount of blue in the theme (diverges from base Nord).
    reduced_blue = true,
    -- Swap the dark background with the normal one.
    swap_backgrounds = false,
    -- Override the styling of any highlight group.
    -- override = {},
    override = {
        TelescopePromptTitle = {
            fg = palette.gray1,
            bg = palette.yellow.base,
            italic = false,
            underline = false,
            sp = palette.red.dim,
            undercurl = false,
        }
    },
    -- Cursorline options.  Also includes visual/selection.
    cursorline = {
        -- Bold font in cursorline.
        bold = false,
        -- Bold cursorline number.
        bold_number = true,
        -- Available styles: 'dark', 'light'.
        theme = 'dark',
        -- Blending the cursorline bg with the buffer bg.
        blend = 0.85,
    },
    noice = {
        -- Available styles: `classic`, `flat`.
        style = 'classic',
    },
    telescope = {
        -- Available styles: `classic`, `flat`.
        style = 'classic',
    },
    leap = {
        -- Dims the backdrop when using leap.
        dim_backdrop = false,
    },
    ts_context = {
        -- Enables dark background for treesitter-context window
        dark_background = true,
    }
}

vim.cmd("colorscheme nordic")

-- Set the background to transparent
vim.cmd[[
hi Normal guibg=NONE ctermbg=NONE
]]

