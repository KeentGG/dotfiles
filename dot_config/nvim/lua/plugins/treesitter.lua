-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.auto_install = true
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      "css",
      "html",
      "javascript",
      "json",
      "python",
      "tsx",
      "typescript",
      "vue",
      "svelte",
      "astro",
    })
    opts.highlight = {
      enable = true,
    }
    opts.autotag = {
      enable = true,
    }
    opts.indents = {
      enable = true,
    }
    opts.textsubjects = {
      enable = true,
    }
  end,
}
