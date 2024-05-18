-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    init = function() require("mini.surround").setup() end,
  },
  {
    "stevearc/conform.nvim",
    -- enabled = false,
    opts = {
      quiet = true,
      formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        sh = { "beautysh" },
        zsh = { "beautysh" },
        astro = { { "prettier" } },
      },
      format_on_save = function(bufnr)
        -- Disable autoformat for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match "/node_modules/" then return end

        return { timeout_ms = 1500, lsp_fallback = true, async = true }
      end,
      format_after_save = { lsp_fallback = true, async = true },
    },
  },
  config = function(_, opts)
    local conform = require "conform"
    conform.setup(opts)

    -- -- Customize prettier args
    -- require("conform.formatters.prettier").args = function(self, ctx)
    --   local prettier_roots = { ".prettierrc", ".prettierrc.json", "prettier.config.js" }
    --   local args = { "--stdin-filepath", "$FILENAME" }
    --
    --   local localPrettierConfig = vim.fs.find(prettier_roots, {
    --     upward = true,
    --     path = ctx.dirname,
    --     type = "file",
    --   })[1]
    --   local globalPrettierConfig = vim.fs.find(prettier_roots, {
    --     path = vim.fn.stdpath "config",
    --     type = "file",
    --   })[1]
    --   local disableGlobalPrettierConfig = os.getenv "DISABLE_GLOBAL_PRETTIER_CONFIG"
    --
    --   -- Project config takes precedence over global config
    --   if localPrettierConfig then
    --     vim.list_extend(args, { "--config", localPrettierConfig })
    --   elseif globalPrettierConfig and not disableGlobalPrettierConfig then
    --     vim.list_extend(args, { "--config", globalPrettierConfig })
    --   end
    --
    --   local hasTailwindPrettierPlugin = vim.fs.find("node_modules/prettier-plugin-tailwindcss", {
    --     upward = true,
    --     path = ctx.dirname,
    --     type = "directory",
    --   })[1]
    --
    --   if hasTailwindPrettierPlugin then vim.list_extend(args, { "--plugin", "prettier-plugin-tailwindcss" }) end
    --
    --   return args
    -- end
    --
    -- conform.formatters.beautysh = {
    --   prepend_args = function() return { "--indent-size", "2", "--force-function-style", "fnpar" } end,
    -- }
  end,
}
