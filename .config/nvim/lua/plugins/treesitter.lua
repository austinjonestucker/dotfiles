return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        dependencies = {
            "windwp/nvim-ts-autotag",
            -- "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            -- autotag
            require("nvim-ts-autotag").setup()

            -- textobjects plugin now uses its own setup + keymaps
            -- require("nvim-treesitter-textobjects").setup({
            --     move = {
            --         set_jumps = false,
            --     },
            --     select = {
            --         lookahead = true,
            --     },
            -- })
            require("nvim-treesitter").install({
              "bash",
              "c",
              "go",
              "graphql",
              "html",
              "java",
              "javascript",
              "json",
              "lua",
              "markdown",
              "markdown_inline",
              "python",
              "query",
              "regex",
              "sql",
              "terraform",
              "typescript",
              "vim",
              "vimdoc",
              "yaml",
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "*" },
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    if
                        lang
                        and vim.tbl_contains(
                            vim.tbl_map(
                                function(p)
                                    return vim.fn.fnamemodify(p, ":t:r")
                                end,
                                vim.api.nvim_get_runtime_file("parser/*", true)
                            ),
                            lang
                        )
                    then
                        vim.treesitter.start()
                        -- if vim.treesitter.query.get(lang, "indents") then
                        --     vim.bo.indentexpr =
                        --         "v:lua.require'nvim-treesitter'.indentexpr()"
                        -- end
                        if vim.treesitter.query.get(lang, "folds") then
                            vim.wo[0][0].foldexpr =
                                "v:lua.vim.treesitter.foldexpr()"
                            vim.wo[0][0].foldmethod = "expr"
                        end
                    end
                end,
            })
        end,
    },
    -- {
    --     "folke/flash.nvim",
    --     event = "VeryLazy",
    --     ---@type Flash.Config
    --     opts = {
    --         modes = {
    --             char = {
    --                 jump_labels = true,
    --             },
    --             search = {
    --                 enabled = true,
    --                 highlight = {
    --                     groups = {
    --                         backdrop = "FlashBackdrop",
    --                         current = "FlashCurrent",
    --                         label = "FlashLabel",
    --                         secondary = "FlashSecondary",
    --                     },
    --                 },
    --             },
    --         },
    --     },
    --     keys = {
    --       { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    --       { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    --       { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    --       { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --       { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    --     },
    -- }
}
