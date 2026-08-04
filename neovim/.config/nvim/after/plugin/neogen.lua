local neogen = require('neogen')
local cmp = require('cmp')

neogen.setup({
  enabled = true,
  languages = {
    python = {
      template = {
        annotation_convention = 'google_docstrings'
      }
    }
  }
})

vim.keymap.del('n', '<leader>d', { silent = true })

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>dg", ":lua require('neogen').generate()<CR>", opts)

-- -- Tab between elements in the generated docstring
-- cmp.setup {
--   mapping = {
--     ["<tab>"] = cmp.mapping(function(fallback)
--       if neogen.jumpable() then
--         neogen.jump_next()
--       else
--         fallback()
--       end
--     end, {
--       "i",
--       "s",
--     }),
--     ["<S-tab>"] = cmp.mapping(function(fallback)
--       if neogen.jumpable(true) then
--         neogen.jump_prev()
--       else
--         fallback()
--       end
--     end, {
--       "i",
--       "s",
--     }),
--   },
-- }
