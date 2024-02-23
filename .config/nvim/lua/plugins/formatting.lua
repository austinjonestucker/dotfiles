return {
  -- Mason Linters & Formatters
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        python = { 'ruff' },
      }
      vim.keymap.set({ 'n', 'v' }, '<leader>ml', function()
        lint.try_lint()
      end, { desc = 'Lint file or range (in visual mode)' })
      vim.keymap.set({ 'n', 'v' }, '<leader>mf', function()
        lint.try_format()
      end, { desc = 'Format file or range (in visual mode)' })
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
          lua = { 'stylua' },
          python = { 'ruff_format' },
        },
      }
      vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end, { desc = 'Format file or range (in visual mode)' })
    end,
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {},
  },
}
