if vim.g.vscode then
    do return end
end

require('Comment').setup({
    ignore = '^$'
})
