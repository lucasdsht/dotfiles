{pkgs, ...}:

{
  programs.nvf = {
    enable = true;
    
    settings = {
      vim = {
        
        options = {
           tabstop = 2;
           shiftwidth = 2;
           wrap = false;
        };

        statusline.lualine.enable = true;
	      filetree.nvimTree = {
          enable = true;
          mappings = {
            toggle = "ff";
          };
        };

        telescope = {
          enable = true;
          mappings = {
            findFiles = "pf";
            liveGrep = "ps";
          };
	      };

        treesitter = {
          enable = true;
        };

        lsp = {
	        enable = true;
	      };

        autocomplete.nvim-cmp = {
          enable = true;
          mappings = {
            scrollDocsUp = "<C-b>";
            scrollDocsDown = "<C-f>";
            close = "<C-e>";
            complete = "<C-Space>";
            confirm = "<CR>";
            next = "<C-n>";
            previous = "<C-p>";

          };
        };

        languages = {
          nix.enable = true;
          rust.enable = true;
          ts.enable = true;
          python.enable = true;
        };

        extraPlugins = with pkgs.vimPlugins; [
          base16-colorscheme
        ];

        luaConfigRC.matugen = ''
          local function source_matugen()
          local path = os.getenv("HOME") .. "/.config/nvim/nvim-colors.lua"

            local f = io.open(path, "r")
            if f == nil then
              -- fallback if matugen hasn't generated anything yet
              pcall(vim.cmd, "colorscheme base16")
              return
            end
            f:close()

            pcall(dofile, path)

            -- ensure lualine re-picks the base16 palette after reload
            pcall(function()
              require("lualine").setup({ options = { theme = "base16" } })
            end)
          end

          -- load once on startup
          source_matugen()

          -- reload live when matugen runs: `pkill -SIGUSR1 nvim`
          vim.api.nvim_create_autocmd("Signal", {
            pattern = "SIGUSR1",
            callback = function()
              source_matugen()
            end,
          })
      '';
      };
    };
  };
}
