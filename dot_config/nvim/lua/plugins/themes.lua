return {
  "rose-pine/neovim",
  name = "rose-pine",
  init = function()
    require("rose-pine").setup {
      variant = "moon",
      styles = {
        bold = false,
        italic = true,
        transparency = true,
      },
    }
  end,
  opts = {},
}
