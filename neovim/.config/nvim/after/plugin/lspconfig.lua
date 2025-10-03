if vim.g.vscode then
  do return end
end

local shellcheck_args = {
  'add-default-case',
  'check-set-e-suppressed',
  'check-unassigned-uppercase',
  'deprecate-which',
  'quote-safe-variables',
  'require-double-brackets',
  'require-variable-braces',
}

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  nmap('<leader>ff', function()
    vim.lsp.buf.format { async = false }
  end, 'Format Code')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local null_ls = require('null-ls')
null_ls.setup {
  on_attach = on_attach,
  sources = {
    -- null_ls.builtins.formatting.isort.with({
    --   extra_args = { '--profile', 'black' },
    -- }),
    -- null_ls.builtins.formatting.black,
    -- null_ls.builtins.diagnostics.pylint.with({
    --   diagnostics_format = "[#{c}] #{m} (#{s})",
    --   debounce = 700,
    --   timeout = 10000
    -- }),
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.yamlfmt,
  },
  capabilities = capabilities,
}

-- Setup neovim lua configuration
require('neodev').setup()

require('mason').setup()
-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  automatic_enable = true,
  ensure_installed = {
    'bashls',
    'clangd',
    'docker_compose_language_service',
    'dockerls',
    'efm',
    'gopls',
    'lua_ls',
    'jsonls',
    'phpactor',
    'pyright',
    'terraformls',
    'tflint',
    'sqlls',
    'yamlls',
    'ruff'
  }
}

require('mason-tool-installer').setup {
  ensure_installed = {
    'goimports',
    'jq',
    'tflint',
    'yamllint'
  }
}

--
-- Global LSP configs along with non-default settings for specific LSPs
--
vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = capabilities
})

vim.lsp.config('bashls', {
  filetypes = { 'sh', 'zsh' },
})

vim.lsp.config('efm', {
  filetypes = { 'sh' },
  settings = {
    documentFormatting = true,
    languages = {
      sh = {
        {
          lintCommand = string.format('shellcheck -f gcc -x -o %s -', table.concat(shellcheck_args, ',')),
          lintSource = 'shellcheck',
          lintIgnoreExitCode = true,
          lintStdin = true,
          lintFormats = {
            '%f:%l:%c: %trror: %m',
            '%f:%l:%c: %tarning: %m',
            '%f:%l:%c: %tote: %m',
          },
        },
        {
          formatCommand = 'shfmt -i 4 -filename "${INPUT}" -',
          formatStdin = true,
        },
      },
    },
  }
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }
})

vim.lsp.config('pyright', {
  settings = {
    disableOrganizeImports = true,
    python = {
      analysis = {
        -- autoImportCompletions = true,
        ignore = { '*' }
      },
    },
  }
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true
    })

    vim.lsp.buf.format({ async = false })
  end
})

-- vim: ts=2 sts=2 sw=2 et
