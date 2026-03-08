return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "gradle-language-server",
        "copilot-language-server",
        "dockerfile-language-server",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "json-lsp",
        "yaml-language-server",
      },
    },
  },
}
