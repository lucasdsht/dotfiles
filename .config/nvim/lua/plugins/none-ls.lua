return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    -- import eslint_d from extras
    local eslint_d = require("none-ls.diagnostics.eslint_d")

    local function has_eslint_config(utils)
      return utils.root_has_file({
        ".eslintrc",
        ".eslintrc.json",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        "package.json",
      })
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        eslint_d.with({ condition = has_eslint_config }),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

    -- 🔧 disable eslint LSP if it's installed
    local lspconfig = require("lspconfig")
    if lspconfig.eslint then
      lspconfig.eslint.setup({
        enabled = false,
      })
    end
  end,
}

