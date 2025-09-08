return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- Default to mocha if nothing is found
    local flavour = "mocha"

    -- Read the flavour from cache (~/.cache/theme)
    local cache_file = vim.fn.expand("~/.cache/theme")
    local f = io.open(cache_file, "r")
    if f then
      local line = f:read("*l")
      if line == "latte" or line == "mocha" or line == "frappe" or line == "macchiato" then
        flavour = line
      end
      f:close()
    end

    -- Set flavour globally for catppuccin
    require("catppuccin").setup({ flavour = flavour })

    -- Force apply it here
    require("catppuccin").load(flavour)
  end,
}

