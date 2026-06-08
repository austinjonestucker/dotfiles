return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
      require('mini.pairs').setup()
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
