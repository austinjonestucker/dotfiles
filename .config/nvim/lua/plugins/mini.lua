return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
      --require('mini.pairs').setup()
      require('mini.surround').setup()

      -- Surround word under cursor from normal mode
      local surround_word = function(char)
        return function() vim.cmd('normal saiw' .. char) end
      end
      vim.keymap.set('n', "<leader>'", surround_word("'"), { desc = "Surround word with ''" })
      vim.keymap.set('n', '<leader>"', surround_word('"'), { desc = 'Surround word with ""' })
      vim.keymap.set('n', '<leader>(', surround_word('('), { desc = 'Surround word with ()' })
      vim.keymap.set('n', '<leader>{', surround_word('{'), { desc = 'Surround word with {}' })
      require('mini.sessions').setup()
      --require('mini.tabline').setup()
    end,
  },
  {
    'nvim-mini/mini.diff',
    opts = {
      view = {
        style = 'sign',
        -- Signs used for hunks with 'sign' view
        signs = { add = '+', change = '~', delete = '-' },
      },
    },
  },
}
