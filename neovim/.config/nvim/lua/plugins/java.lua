return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Vi deklarerar jdtls här så att LazyVim fattar att det ska finnas
        jdtls = {},
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "java" },
    opts = function()
      -- 1. Hitta root med säkerhetsmarginal
      local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" })

      -- Om vi inte hittar en projekt-root, använd nuvarande mapp (så jdtls faktiskt startar)
      if not root_dir or root_dir == "" then
        root_dir = vim.fn.getcwd()
      end

      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/site/java-workspace/" .. project_name

      return {
        cmd = {
          "jdtls",
          "-data",
          workspace_dir,
          -- Tips: Lägg till --jvm-arg=-XX:+UseParallelGC om det går trögt
        },
        root_dir = root_dir,
        settings = {
          java = {
            format = {
              enabled = true,
              settings = {
                -- Tre snedstreck efter file: är viktigt på Linux
                url = "file://" .. vim.fn.expand("~/.config/nvim/java-style/eclipse-formatter.xml"),
                profile = "MittProjektProfilNamn",
              },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
          },
        },
        init_options = {
          extendedClientCapabilities = {
            progressReportProvider = true,
          },
        },
      }
    end,
    config = function(_, opts)
      -- Vi använder en LspStart istället för bara FileType för att vara säkra
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          require("jdtls").start_or_attach(opts)
        end,
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        java = { "checkstyle" },
      },
      linters = {
        checkstyle = {
          -- Här expanderar vi sökvägen ordentligt
          args = {
            "-c",
            vim.fn.expand("~/.config/nvim/java-style/checkstyle.xml"),
            "-f",
            "sarif",
          },
        },
      },
    },
  },

  {
    "elmcgill/springboot-nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-jdtls",
    },
    opts = {}, -- Det är bra att ha opts även om den är tom för Lazy
    config = function()
      local springboot_nvim = require("springboot-nvim")
      -- Keymaps med leader J
      vim.keymap.set("n", "<leader>Jr", springboot_nvim.boot_run, { desc = "Spring Boot Run Project" })
      vim.keymap.set("n", "<leader>Jc", springboot_nvim.generate_class, { desc = "Java Create Class" })
      vim.keymap.set("n", "<leader>Ji", springboot_nvim.generate_interface, { desc = "Java Create Interface" })
      vim.keymap.set("n", "<leader>Je", springboot_nvim.generate_enum, { desc = "Java Create Enum" })

      springboot_nvim.setup({})
    end,
  },
}
