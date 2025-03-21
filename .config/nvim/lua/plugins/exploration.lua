return {
  -- Images in neovim support.
  -- {
  --   'vhyrro/luarocks.nvim',
  --   priority = 1001, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  --   rocks = { 'magick' }, -- specifies a list of rocks to install
  --   config = true,
  -- },
  -- {
  --   '3rd/image.nvim',
  --   version = '1.3.0',
  --   dependencies = { 'luarocks.nvim' },
  --   config = function()
  --     require('image').setup {
  --       backend = 'kitty',
  --       kitty_method = 'unicode-placeholders',
  --       integrations = {
  --         markdown = {
  --           enabled = true,
  --           clear_in_insert_mode = false,
  --           download_remote_images = true,
  --           only_render_image_at_cursor = false,
  --           filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
  --         },
  --         neorg = {
  --           enabled = true,
  --           clear_in_insert_mode = false,
  --           download_remote_images = true,
  --           only_render_image_at_cursor = false,
  --           filetypes = { 'norg' },
  --         },
  --       },
  --       max_width = nil,
  --       max_height = nil,
  --       max_width_window_percentage = nil,
  --       max_height_window_percentage = 50,
  --       window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  --       window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
  --       editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  --       tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --       hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
  --     }
  --   end,
  -- },
  -- {
  --   'quarto-dev/quarto-nvim',
  --   dependencies = { 'jmbuhr/otter.nvim' },
  --   config = function()
  --     require('quarto').setup {
  --       lspFeatures = {
  --         -- NOTE: put whatever languages you want here:
  --         languages = { 'r', 'python' },
  --         chunks = 'all',
  --         diagnostics = {
  --           enabled = true,
  --           triggers = { 'BufWritePost' },
  --         },
  --         completion = {
  --           enabled = true,
  --         },
  --       },
  --       keymap = {
  --         -- NOTE: setup your own keymaps:
  --         hover = 'K',
  --         definition = 'gd',
  --         type_definition = 'gD',
  --         rename = '<leader>lR',
  --         format = '<leader>lf',
  --         references = 'gr',
  --         document_symbols = 'gS',
  --       },
  --       codeRunner = {
  --         enabled = true,
  --         default_method = 'molten',
  --       },
  --     }
  --   end,
  -- },
  -- -- Add Jupyter Notebook support
  -- {
  --   'GCBallesteros/jupytext.nvim',
  --   config = function()
  --     require('jupytext').setup {
  --       style = 'markdown',
  --       output_extension = 'md',
  --       force_ft = 'markdown',
  --       lazy = false,
  --     }
  --   end,
  -- },
  -- {
  --   'benlubas/molten-nvim',
  --   version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
  --   -- dependencies = { '3rd/image.nvim' },
  --   build = ':UpdateRemotePlugins',
  --   ft = { 'quarto', 'markdown' },
  --   config = function()
  --     -- I find auto open annoying, keep in mind setting this option will require setting
  --     -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
  --     vim.g.molten_auto_open_output = false

  --     -- this guide will be using image.nvim
  --     -- Don't forget to setup and install the plugin if you want to view image outputs
  --     -- vim.g.molten_image_provider = 'image.nvim'

  --     -- optional, I like wrapping. works for virt text and the output window
  --     vim.g.molten_wrap_output = true

  --     -- Output as virtual text. Allows outputs to always be shown, works with images, but can
  --     -- be buggy with longer images
  --     vim.g.molten_virt_text_output = true

  --     -- this will make it so the output shows up below the \`\`\` cell delimiter
  --     vim.g.molten_virt_lines_off_by_1 = true

  --     vim.keymap.set('n', '<localleader>e', ':MoltenEvaluateOperator<CR>', { desc = 'evaluate operator', silent = true })
  --     vim.keymap.set('n', '<localleader>os', ':noautocmd MoltenEnterOutput<CR>', { desc = 'open output window', silent = true })
  --     vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>', { desc = 're-eval cell', silent = true })
  --     vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { desc = 'execute visual selection', silent = true })
  --     vim.keymap.set('n', '<localleader>oh', ':MoltenHideOutput<CR>', { desc = 'close output window', silent = true })
  --     vim.keymap.set('n', '<localleader>md', ':MoltenDelete<CR>', { desc = 'delete Molten cell', silent = true })

  --     -- if you work with html outputs:
  --     vim.keymap.set('n', '<localleader>mx', ':MoltenOpenInBrowser<CR>', { desc = 'open output in browser', silent = true })

  --     -- quatro keymaps
  --     local runner = require 'quarto.runner'
  --     vim.keymap.set('n', '<localleader>rc', runner.run_cell, { desc = 'run cell', silent = true })
  --     vim.keymap.set('n', '<localleader>ra', runner.run_above, { desc = 'run cell and above', silent = true })
  --     vim.keymap.set('n', '<localleader>rA', runner.run_all, { desc = 'run all cells', silent = true })
  --     vim.keymap.set('n', '<localleader>rl', runner.run_line, { desc = 'run line', silent = true })
  --     vim.keymap.set('v', '<localleader>r', runner.run_range, { desc = 'run visual range', silent = true })
  --     vim.keymap.set('n', '<localleader>RA', function()
  --       runner.run_all(true)
  --     end, { desc = 'run all cells of all languages', silent = true })
  --   end,
  -- },
  -- Add database and warehouse plugins
}
