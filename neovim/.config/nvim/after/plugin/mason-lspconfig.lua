if vim.g.vscode then
    do return end
end

-- LSPs we want to install and manage via mason
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#automatic-server-setup-advanced-feature
local shellcheck_args = {
  'add-default-case',
  'check-set-e-suppressed',
  'check-unassigned-uppercase',
  'deprecate-which',
  'quote-safe-variables',
  'require-double-brackets',
  'require-variable-braces',
}

local servers = {
  clangd = {},
  docker_compose_language_service = {},
  dockerls = {},
  efm = {
    filetypes = { 'sh' },
    init_options = { documentFormatting = true },
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
      }
    },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  pylsp = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        black = {
          enabled = true,
          line_length = 79,
        },
        jedi_completion = {
          enabled = true,
          include_params = true,
          fuzzy = true,
        },
        pycodestyle = { enabled = false },
        isort = { enabled = true, profile = 'black' },
        pylsp_mypy = {
          enabled = true,
          -- The hacks! The hacks!
          -- NOTE: This works regardless of mypy's presence in the virtual env
          -- overrides = { "--python-executable", '/bin/sh -c \'if [[ -n "${VIRTUAL_ENV:-}" ]]; then "${VIRTUAL_ENV}/bin/python"; else /usr/bin/python3; fi\'', true },
          overrides = { true, "--python-executable", vim.fn.expand("$HOME/bin/mypy_python.sh"), },
        },
        pylint = {
          enabled = true,
          -- The hacks! The hacks!
          -- NOTE: This does **NOT** work if pylint is missing from the virtual env
          -- TODO: Fix that somehow without PYTHONPATH hacks
          executable = 'python $(command -v pylint) || pylint',
          debounce = 200,
        },
        yapf = { enabled = false },
      }
    }
  },
  sqlls = {},
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
    vim.lsp.buf.format { async = true }
    end, 'Format Code')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()
-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
      init_options = (servers[server_name] or {}).init_options,
    }
  end
}

-- vim: ts=2 sts=2 sw=2 et
