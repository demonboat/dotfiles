return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "bold", -- Klassnamn och typer blir bold som i IntelliJ
          functions = "NONE", -- Ofta är metoder "plain" i IntelliJ
          variables = "NONE",
        },
      },
      -- Här finjusterar vi specifika grupper för att efterlikna IntelliJ
      groups = {
        all = {
          -- Parametrar i metoder är ofta kursiva i moderna IDE:er
          ["@parameter"] = { style = "italic" },
          -- Annotationer (@Override, @SpringBootApplication)
          ["@attribute"] = { style = "bold" },
          -- Statiska fält/metoder (IntelliJ kör ofta italic på dessa)
          ["@constant.builtin"] = { style = "italic" },
          ["@variable.builtin"] = { style = "italic" },
        },
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
      vim.cmd("colorscheme dayfox")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dayfox",
    },
  },
}
