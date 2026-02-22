require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = false,            -- enable undercurls
    commentStyle = { italic = false },
    functionStyle = { italic = false },
    keywordStyle = { italic = false},
    statementStyle = { bold = true, italic = false },
    typeStyle = { italic = false },
    transparent = true,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { 
            wave = {}, 
            lotus = {}, 
            dragon = {
              -- syn = {
              --   string     = palette.dragonGreen2,
              --   variable   = "none",
              --   number     = palette.dragonPink,
              --   constant   = palette.dragonOrange,
              --   identifier = palette.dragonYellow,
              --   parameter  = palette.dragonGray,
              --   fun        = palette.dragonBlue2,
              --   statement  = palette.dragonViolet,
              --   keyword    = palette.dragonViolet,
              --   operator   = palette.dragonRed,
              --   preproc    = palette.dragonRed,
              --   type       = palette.dragonAqua,
              --   regex      = palette.dragonRed,
              --   deprecated = palette.katanaGray,
              --   punct      = palette.dragonGray2,
              --   comment    = palette.dragonAsh,
              --   special1   = palette.dragonTeal,
              --   special2   = palette.dragonRed,
              --   special3   = palette.dragonRed,
              -- },
              syn = {
                -- string   = "#b6927b",
                string   = "#a292a3", -- dragonPink
                number   = "#87a987", -- dragonGreen
                constant = "#c4b28a", -- dragonYellow
                preproc  = "#8992a7", -- dragonViolet
                special3 = "#b98d7b"  -- dragonOrange2
              },
            },
            all = {}
        },
    },
    overrides = function(colors) -- add/modify highlights
        return {
          ["@variable.builtin"] = { italic = false },
        }
    end,
    background = {               -- map the value of 'background' option to a theme
        dark = "dragon",           -- try "dragon" !
        light = "lotus"
    },
})

 require('nightfox').setup({
   options = {
     -- Compiled file's destination location
     compile_path = vim.fn.stdpath("cache") .. "/nightfox",
     compile_file_suffix = "_compiled", -- Compiled file suffix
     transparent = true,     -- Disable setting background
     terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
     dim_inactive = false,    -- Non focused panes set to alternative background
     module_default = true,   -- Default enable value for modules
     colorblind = {
       enable = false,        -- Enable colorblind support
       simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
       severity = {
         protan = 0,          -- Severity [0,1] for protan (red)
         deutan = 0,          -- Severity [0,1] for deutan (green)
         tritan = 0,          -- Severity [0,1] for tritan (blue)
       },
     },
     styles = {               -- Style to be applied to different syntax groups
       comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
       conditionals = "NONE",
       constants = "NONE",
       functions = "NONE",
       keywords = "NONE",
       numbers = "NONE",
       operators = "NONE",
       strings = "NONE",
       types = "NONE",
       variables = "NONE",
     },
     inverse = {             -- Inverse highlight for different types
       match_paren = false,
       visual = false,
       search = false,
     },
     modules = {             -- List of various plugins and additional options
       -- ...
     },
   },
   palettes = {},
   specs = {},
   groups = {},
 })

local palette = require 'nordic.colors'
require 'nordic' .setup {
    -- This callback can be used to override the colors used in the palette.
    on_palette = function(palette) return palette end,
    -- Enable bold keywords.
    bold_keywords = true,
    -- Enable italic comments.
    italic_comments = false,
    -- Enable general editor background transparency.
    transparent = {
      bg = true
    },
    -- Enable brighter float border.
    bright_border = true,
    -- Reduce the overall amount of blue in the theme (diverges from base Nord).
    reduced_blue = true,
    -- Swap the dark background with the normal one.
    swap_backgrounds = false,
    -- Override the styling of any highlight group.
    -- override = {},
    on_highlight = function(highlights, palette)
        highlights.TelescopePromptTitle = {
            fg = palette.gray1,
            bg = palette.green.bright,
            italic = false,
            underline = false,
            sp = palette.red.dim,
            undercurl = false,
        }
        for _, highlight in pairs(highlights) do
            highlight.italic = false
        end
    end,
    -- Cursorline options.  Also includes visual/selection.
    cursorline = {
        -- Bold font in cursorline.
        bold = true,
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

---- Set highlight background to be light gray
vim.api.nvim_set_hl(0, "Visual", { bg = "#4B5263" })

-- Set highlight background for LSP diagnostic to be transparent
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#FF0000", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#FFA500", bg = "NONE" })
-- Make line numbers transparent
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'NONE' })
-- Make the sign column transparent
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })

-- Default colorscheme
-- vim.cmd("colorscheme kanagawa")

-- Seoulbones settings (pre-configure before loading)
vim.g.seoulbones_italic_comments = false
vim.g.seoulbones_italic_strings = false
vim.g.zenbones_solid_line_nr = true

-- Function to apply seoulbones with custom overrides for Zig files
local function apply_zig_colorscheme()
  vim.cmd("colorscheme seoulbones")

  -- Override string and comment colors (muted coral)
  vim.api.nvim_set_hl(0, "String", { fg = "#d8b0a0" })
  vim.api.nvim_set_hl(0, "@string", { fg = "#d8b0a0" })
  vim.api.nvim_set_hl(0, "Comment", { fg = "#d8b0a0" })
  vim.api.nvim_set_hl(0, "@comment", { fg = "#d8b0a0" })

  -- Make type declarations white like variables
  vim.api.nvim_set_hl(0, "Type", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@type", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#f0f0f0" })

  -- Make constructors and enum literals white
  vim.api.nvim_set_hl(0, "@constructor", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@constant.builtin", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@punctuation.special", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@variable.member", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@field", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@property", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@module", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@namespace", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@lsp.type.namespace", { fg = "#f0f0f0" })

  -- Functions with subtle punch (pale yellow)
  vim.api.nvim_set_hl(0, "Function", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@function", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@function.call", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@function.method", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@method", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@method.call", { fg = "#e8d6aa" })

  -- Visual and Search highlights
  vim.api.nvim_set_hl(0, "Visual", { bg = "#3d3a50" })     -- dusty purple
  vim.api.nvim_set_hl(0, "Search", { bg = "#3d3a50", fg = "#ffffff" })
  vim.api.nvim_set_hl(0, "IncSearch", { bg = "#4a3a5a", fg = "#ffffff" })

  -- Transparent background
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1e2a3a" })
end

-- Function to restore default colorscheme
local function apply_default_colorscheme()
  vim.cmd("colorscheme kanagawa")

  -- Orange Comments
  
  -- vim.api.nvim_set_hl(0, "Comment", { fg = "#d8b0a0" })
  -- vim.api.nvim_set_hl(0, "@comment", { fg = "#d8b0a0" })

  vim.api.nvim_set_hl(0, "Comment", { fg = "#b8a098" })
  vim.api.nvim_set_hl(0, "@comment", { fg = "#b8a098" })

  -- vim.api.nvim_set_hl(0, "Comment", { fg = "#a89088" })
  -- vim.api.nvim_set_hl(0, "@comment", { fg = "#a89088" })


  -- White Constants
  vim.api.nvim_set_hl(0, "Constant", { fg = "#e4e4e4" })
  vim.api.nvim_set_hl(0, "@constant", { fg = "#e4e4e4" })
  vim.api.nvim_set_hl(0, "@lsp.type.constant", { fg = "#e4e4e4" })
  -- vim.api.nvim_set_hl(0, "@lsp.type.constant", { fg = "#f0f0f0" })
  
  -- White struct fields/attributes
  vim.api.nvim_set_hl(0, "@field", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@property", { fg = "#f0f0f0" })
  vim.api.nvim_set_hl(0, "@variable.member", { fg = "#f0f0f0" })

  -- White Variables
  vim.api.nvim_set_hl(0, "@variable", { fg = "#d4d4d4" })
  vim.api.nvim_set_hl(0, "Identifier", { fg = "#d4d4d4" })
  vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "#d4d4d4" })
  vim.api.nvim_set_hl(0, "@parameter", { fg = "#d4d4d4" })


  -- Purple Modules
  vim.api.nvim_set_hl(0, "@module", { fg = "#9090c0" })

  -- -- Green Types
  -- vim.api.nvim_set_hl(0, "Type", { fg = "#8cc8c8" })
  -- vim.api.nvim_set_hl(0, "@type", { fg = "#8cc8c8" })
  -- vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#8cc8c8" })

  -- Steel cyan Types
  vim.api.nvim_set_hl(0, "Type", { fg = "#8cb8c8" })
  vim.api.nvim_set_hl(0, "@type", { fg = "#8cb8c8" })
  vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#8cb8c8" })

  -- Yellow Functions
  vim.api.nvim_set_hl(0, "Function", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@function", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@function.call", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@function.method", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@method", { fg = "#e8d6aa" })
  vim.api.nvim_set_hl(0, "@method.call", { fg = "#e8d6aa" })

  -- Earthy clay Booleans and Operators
  vim.api.nvim_set_hl(0, "Boolean", { fg = "#c89080" })
  vim.api.nvim_set_hl(0, "@boolean", { fg = "#c89080" })
  vim.api.nvim_set_hl(0, "Operator", { fg = "#c89080" })
  vim.api.nvim_set_hl(0, "@operator", { fg = "#c89080" })
  vim.api.nvim_set_hl(0, "@keyword.operator", { fg = "#c89080" })

  -- Visual and Search highlights
  vim.api.nvim_set_hl(0, "Visual", { bg = "#3d3a50" })     -- dusty purple
  vim.api.nvim_set_hl(0, "Search", { bg = "#3d3a50", fg = "#ffffff" })
  vim.api.nvim_set_hl(0, "IncSearch", { bg = "#4a3a5a", fg = "#ffffff" })

  -- Transparent background
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
end

-- Autocommands for Zig files
-- vim.api.nvim_create_augroup("ZigColorscheme", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   group = "ZigColorscheme",
--   pattern = "*.zig",
--   callback = apply_zig_colorscheme,
-- })
-- vim.api.nvim_create_autocmd("BufLeave", {
--   group = "ZigColorscheme",
--   pattern = "*.zig",
--   callback = apply_default_colorscheme,
-- })


-- Set the background to transparent
vim.cmd[[
hi Normal guibg=NONE ctermbg=NONE
]]

---- Set highlight background to be light gray
vim.api.nvim_set_hl(0, "Visual", { bg = "#4B5263" })
-- vim.api.nvim_set_hl(0, "Visual", { bg = "#ffe7be" })

-- Set highlight background for LSP diagnostic to be transparent
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#FF0000", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#FFA500", bg = "NONE" })
-- Make line numbers transparent
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'NONE' })
-- Make the sign column transparent
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })

-- vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1e2228' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#1e2a3a' })

vim.opt.termguicolors = true
vim.opt.winblend = 30
vim.opt.cursorline = true

-- Fix Snacks.nvim window bg
vim.api.nvim_set_hl(0, "SnacksNotifierInfo", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksNotifierWarn", { bg = "NONE" })  
vim.api.nvim_set_hl(0, "SnacksNotifierError", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksTerminal", { link = "Normal" })

-- General floating window fix
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

apply_default_colorscheme()
