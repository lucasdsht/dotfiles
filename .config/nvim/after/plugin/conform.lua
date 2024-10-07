local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = {{"prettierd", "prettier"}},
    ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true
  }
})
