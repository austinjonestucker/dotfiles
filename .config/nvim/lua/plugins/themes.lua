local colors = {
  background = '#1F1F28',
  foreground = '#DCD7BA',
  blue = '#7E9CD8',
  cyan = '#6A9589',
  red = 'C34043',
  violet = '#938aa9',
  grey = '#727169',
  green = '#76946A',
  yellow = '#C0A36E',
}

local kanagawa_theme = {
  normal = {
    a = { fg = colors.background, bg = colors.blue },
    b = { fg = colors.foreground, bg = colors.background },
    c = { fg = colors.foreground, bg = colors.background },
  },

  insert = { a = { fg = colors.background, bg = colors.yellow } },
  visual = { a = { fg = colors.background, bg = colors.violet } },
  replace = { a = { fg = colors.background, bg = colors.red } },

  inactive = {
    a = { fg = colors.foreground, bg = colors.background },
    b = { fg = colors.foreground, bg = colors.background },
    c = { fg = colors.background, bg = colors.background },
  },
}

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
        icons_enabled = false,
        theme = 'nightfly',
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
