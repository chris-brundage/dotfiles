return {
    "luukvbaal/statuscol.nvim", config = function()
        -- local builtin = require("statuscol.builtin")
        require("statuscol").setup({
            relculright = false,
            clickmode = "m",
        })
    end,
}
