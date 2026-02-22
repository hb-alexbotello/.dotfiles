-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Disable zig.vim's auto-formatting to avoid conflicts with ZLS
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>n', vim.lsp.buf.references, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
-- require('lspconfig')['pylsp'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
--     settings = {}
-- }
require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require'lspconfig'.rust_analyzer.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
}

require('lspconfig')['gleam'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig').zls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
    root_dir = function(fname)
        local util = require('lspconfig.util')
        return util.root_pattern('build.zig', '.git')(fname)
    end,
    on_new_config = function(config, root_dir)
        -- Try to find zig in the project directory first
        local project_zig = root_dir .. '/zig/zig'
        local project_lib = root_dir .. '/zig/lib'

        -- Check if project-local zig exists
        if vim.fn.filereadable(project_zig) == 1 then
            config.settings.zls.zig_exe_path = project_zig
            config.settings.zls.zig_lib_path = project_lib
        else
            -- Fall back to system zig (let zls auto-detect or use system PATH)
            config.settings.zls.zig_exe_path = nil
            config.settings.zls.zig_lib_path = nil
        end
    end,
    settings = {
        zls = {
            -- Completion settings
            enable_snippets = true,
            enable_argument_placeholders = true,
            completion_label_details = true,

            -- Build settings
            enable_build_on_save = true,
            build_on_save_args = {},

            -- Semantic tokens
            semantic_tokens = "full",  -- "none", "partial", or "full"

            -- Inlay hints
            inlay_hints_show_variable_type_hints = true,
            inlay_hints_show_struct_literal_field_type = true,
            inlay_hints_show_parameter_name = true,
            inlay_hints_show_builtin = true,
            inlay_hints_exclude_single_argument = true,
            inlay_hints_hide_redundant_param_names = false,
            inlay_hints_hide_redundant_param_names_last_token = false,

            -- Style and diagnostics
            warn_style = false,
            highlight_global_var_declarations = true,

            -- Performance settings
            skip_std_references = false,
            prefer_ast_check_as_child_process = true,

            -- Advanced settings (usually left as nil for auto-detection)
            builtin_path = nil,
            build_runner_path = nil,
            global_cache_path = nil,

            -- Legacy/workaround settings
            force_autofix = false
        }
    }
}

require'lspconfig'.omnisharp.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { "dotnet", "/usr/local/omnisharp/OmniSharp.dll" },

  settings = {
    FormattingOptions = {
      -- Enables support for reading code style, naming convention and analyzer
      -- settings from .editorconfig.
      EnableEditorConfigSupport = true,
      -- Specifies whether 'using' directives should be grouped and sorted during
      -- document formatting.
      OrganizeImports = nil,
    },
    MsBuild = {
      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      LoadProjectsOnDemand = nil,
    },
    RoslynExtensionsOptions = {
      -- Enables support for roslyn analyzers, code fixes and rulesets.
      EnableAnalyzersSupport = nil,
      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      EnableImportCompletion = nil,
      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      -- true
      AnalyzeOpenDocumentsOnly = nil,
    },
    Sdk = {
      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      IncludePrereleases = true,
    },
  },
}

-- local omnisharp_bin = "/usr/local/omnisharp/OmniSharp.dll"
-- require("lspconfig").omnisharp.setup {
--   on_attach = on_attach,
--   flags = lsp_flags,
--   cmd = { "dotnet", omnisharp_bin},
--   -- cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
-- }

-- require'lspconfig'.terraformls.setup{
--   on_attach = on_attach,
--   flags = lsp_flags,
-- }

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- auto format go code on file save
vim.cmd([[autocmd BufWritePre *.go lua vim.lsp.buf.format({ async = true })]])
vim.cmd([[autocmd BufWritePre *.gleam lua vim.lsp.buf.format({ async = true })]])

vim.cmd([[autocmd BufWritePre *.rs lua vim.lsp.buf.format({ async = true })]])

-- auto format terraform code on file save
vim.cmd([[autocmd BufWritePre *.tfvars lua vim.lsp.buf.format({ async = true })]])
vim.cmd([[autocmd BufWritePre *.tf lua vim.lsp.buf.format({ async = true })]])

-- auto format zig code on file save
vim.cmd([[autocmd BufWritePre *.zig lua vim.lsp.buf.format({ async = false })]])
vim.cmd([[autocmd BufWritePre *.zon lua vim.lsp.buf.format({ async = false })]])

-- Add source.fixAll on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.zig", "*.zon"},
    callback = function()
        vim.lsp.buf.code_action({
            context = { only = { "source.fixAll" } },
            apply = true,
        })
    end,
})

-- Add source.organizeImports on save (requires ZLS 0.14+)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = {"*.zig", "*.zon"},
--     callback = function()
--         vim.lsp.buf.code_action({
--             context = { only = { "source.organizeImports" } },
--             apply = true,
--         })
--     end,
-- })
