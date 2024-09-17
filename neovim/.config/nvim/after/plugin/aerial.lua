require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  layout = {
    min_width = 20,
  },
  default_direction = "prefer_left",
  autojump = true,
  close_automatic_events = { "unfocus" },
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>oo", "<cmd>AerialToggle<CR>")
vim.keymap.set("n", "<leader>os", "<cmd>call aerial#fzf()<cr>")
