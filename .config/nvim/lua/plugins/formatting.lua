return {
  -- Mason Linters & Formatters
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        python = { 'ruff' },
        sql = { 'sqlfluff' },
        typscript = { 'eslint_d' },
      }
      vim.keymap.set({ 'n', 'v' }, '<leader>ml', function()
        lint.try_lint()
      end, { desc = 'Lint file or range (in visual mode)' })
    end,
  },
  {
    'rshkarin/mason-nvim-lint',
    config = function()
      require('mason-nvim-lint').setup()
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local conform = require 'conform'
      conform.setup {
        formatters_by_ft = {
          javascript = { 'prettier' },
          lua = { 'stylua' },
          python = { 'ruff_format' },
          sql = { 'sqlfmt'},
          typscript = { 'prettier' },
        },
      }
      vim.keymap.set({ 'n', 'v' }, '<leader>mf', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = 'Format file or range (in visual mode)' })
    end,
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    config = function()
      require('ibl').setup({
        exclude = {
          filetypes = {
            "dashboard"
          }
        }
      })
    end,
  },
}
