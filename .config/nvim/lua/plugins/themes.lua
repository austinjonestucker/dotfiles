return {
  {
    -- Theme inspired by Catppuccin
    'catppuccin/nvim',
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'catppuccin-mocha'
    -- end,
  },
  {
    -- Theme inspired by Gruvbox
    'morhetz/gruvbox',
    priority = 1000,
    --config = function()
    --  vim.cmd.colorscheme 'gruvbox'
    --end,
  },
  {
    -- Theme inspired by Kanagawa (not default)
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'kanagawa-wave'
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        theme = 'horizon',
      },
    },
  },
  {
    -- Add tabs at the top of the screen
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- Éetc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
