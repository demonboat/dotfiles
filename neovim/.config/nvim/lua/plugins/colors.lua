return {
  "EdenEast/nightfox.nvim",
  priority = 1000,
  opts = {
    colorscheme = "dayfox",
  },
  config = function()
    require("nightfox").setup({
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    })
  end,
}
