return {
  -- AI plugins
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        -- panel = {
        --   enabled = true,
        --   auto_refresh = true,
        --   keymap = {
        --     jump_prev = '[[',
        --     jump_next = ']]',
        --     accept = '<CR>',
        --     refresh = 'gr',
        --     open = '<M-CR>',
        --   },
        --   layout = {
        --     position = 'bottom', -- | top | left | right
        --     ratio = 0.4,
        --   },
        -- },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<C-l>',
            accept_word = false,
            accept_line = false,
            next = '<C-,>',
            prev = '<C-.>',
            dismiss = '<C-/>',
          },
        },
        -- suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ['.'] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      }
    end,
  },
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  -- },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      -- model = 'DeepSeek-V3',
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
