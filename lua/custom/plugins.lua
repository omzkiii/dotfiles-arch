local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

-- Override plugin definition options
-- {"nvim-neorg/neorg",lazy = false},
-- {
--   "neovim/nvim-lspconfig",
--   config = function()
--     require "plugins.configs.lspconfig"
--     require "custom.configs.lspconfig"
--   end, -- Override to setup mason-lspconfig
-- },

-- override plugin configs
{
  "williamboman/mason.nvim",
  opts = overrides.mason
},

{
  "nvim-treesitter/nvim-treesitter",
opts = overrides.treesitter,
},

{
  "nvim-tree/nvim-tree.lua",
  opts = overrides.nvimtree,
},

-- Install a plugin
{
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  config = function()
    require("better_escape").setup()
  end,
},

{
  "stevearc/conform.nvim",
  --  for users those who want auto-save conform + lazyloading!
-- event = "BufWritePre"
  config = function()
    require "custom.configs.conform"
  end,
},
-- {
--    "nvim-neorg/neorg",
--   build = ":Neorg sync-parsers",
--   -- tag = "*",
--   dependencies = { "nvim-lua/plenary.nvim" },
--   config = function()
--     require("neorg").setup {
--       load = {
--         ["core.defaults"] = {}, -- Loads default behaviour
--         ["core.concealer"] = {
--           config = {vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"},
--             {pattern = {"*.norg"},
--             command = "set conceallevel=3"})}}, -- Adds pretty icons to your documents
--         ["core.summary"] = {},
--         ["core.dirman"] = { -- Manages Neorg workspaces
--           config = {
--             workspaces = {
--               notes = "~/notes",
--             },
--           },
--         },
--       },
--     }
--   end,
-- },
--  {
--    "oncomouse/lushwal.nvim",
--   cmd = { "LushwalCompile" },
--   dependencies = {
-- 	  { "rktjmp/lush.nvim" },
-- 	  { "rktjmp/shipwright.nvim" },
-- },
--  },
{
  "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
    workspaces = {
        {
          name = "Notes",
          path = "~/Documents/Notes",
        },
      },
      ui = {
        enable = true,  -- set to false to disable all additional syntax features
        update_debounce = 200,  -- update delay after a text change (in milliseconds)
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
            ["x"] = { char = "", hl_group = "ObsidianDone" },
            [">"] = { char = "", hl_group = "ObsidianRightArrow" },
            ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
            -- Replace the above with this if you don't have a patched font:
            -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
            -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

            -- You can also add more custom ones...
          },
        },
        -- Set to false to disable completion.
        nvim_cmp = true,

        -- Trigger completion at 2 chars.
        min_chars = 2,

        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "current_dir",

        -- Either 'wiki' or 'markdown'.
        preferred_link_style = "wiki",

        -- Control how wiki links are completed with these (mutually exclusive) options:
        --
        -- 1. Whether to add the note ID during completion.
        -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
        -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
        prepend_note_id = true,
        -- 2. Whether to add the note path during completion.
        -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
        -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
        prepend_note_path = false,
        -- 3. Whether to only use paths during completion.
        -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
        -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
        use_path_only = false,
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
       },
      disable_frontmatter = true,
      finder = "telescope.nvim",
      finder_mappings = {
        -- Create a new note from your query with `:ObsidianSearch` and `:ObsidianQuickSwitch`.
        -- Currently only telescope supports this.
        new = "<C-x>",
      },
        -- see below for full list of options 👇
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Notes/Excerpts",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
      },
    },
    {
      "echasnovski/mini.animate",
      event = "VeryLazy",
      opts = function()
        -- don't use animate when scrolling with the mouse
        local mouse_scrolled = false
        for _, scroll in ipairs({ "Up", "Down" }) do
          local key = "<ScrollWheel" .. scroll .. ">"
          vim.keymap.set({ "", "i" }, key, function()
            mouse_scrolled = true
            return key
          end, { expr = true })
        end

        local animate = require("mini.animate")
        return {
          resize = {
            enable = false,
          },
          open = {
            enable = false,
          },
          close = {
            enable = false,
          },
          scroll = {
            timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
            subscroll = animate.gen_subscroll.equal({
              predicate = function(total_scroll)
                if mouse_scrolled then
                mouse_scrolled = false
                  return false
                end
                return total_scroll > 1
              end,
            }),
          },
          cursor = {
            -- Animate for 200 milliseconds with linear easing
            timing = animate.gen_timing.cubic({ duration = 20, unit = 'total' }),

            -- Animate with shortest line for any cursor move
            path = animate.gen_path.line({
              predicate = function() return true end,
            }),
          },
        }
      end,
    },
    {
      'linux-cultist/venv-selector.nvim',
      dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
      opts = {
        -- Your options go here
        name = "env",
        auto_refresh = false
      },
      event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
      keys = {
        -- Keymap to open VenvSelector to pick a venv.
        { '<leader>vs', '<cmd>VenvSelect<cr>' },
        -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
        { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
      },
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      -- ft = "*",
      opts = function()
        return require "custom.configs.null-ls"
      end
    },
    -- {
    --     'nvim-telescope/telescope-media-files.nvim',
    -- },
    -- {
    --       "Jezda1337/nvim-html-css",
    --       dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-lua/plenary.nvim",
    --       },
    --       config = function()
    --         require("html-css"):setup()
    --       end,
    -- },
    -- {
    --     'adelarsq/image_preview.nvim',
    --     opts = {mappings = {
    --       ["<leader>i"] = "image_kitty"}
    --     },
    --     event = 'VeryLazy',
    --     config = function()
    --         require("image_preview").setup()
    --           end
    -- },
  -- To make a plugin not be loaded
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
