{ pkgs, ... }:

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

          csharp = {
            enable = true;
            lsp.enable = true;
          };
        };

        extraPlugins = with pkgs.vimPlugins; {
          base16 = {
            package = base16-nvim;
          };

          lualine_theme = {
            package = lualine-nvim;
            after = [ "base16" ];
            setup = ''
              pcall(function()
                require("lualine").setup({
                  options = { theme = "base16" }
                })
              end)
            '';
          };

          snacks = {
            package = snacks-nvim;
            setup = ''
              require("snacks").setup({})
            '';
          };

          claudecode = {
            package = pkgs.vimUtils.buildVimPlugin {
              pname = "claudecode.nvim";
              version = "latest";
              src = pkgs.fetchFromGitHub {
                owner = "coder";
                repo = "claudecode.nvim";
                rev = "main";
                hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
              };
            };

            after = [ "snacks" ];

            setup = ''
              require("claudecode").setup({})
            '';
          };
        };

        keymaps = [
          {
            mode = "n";
            key = "<leader>ac";
            action = "<cmd>ClaudeCode<cr>";
            desc = "Toggle Claude";
          }
          {
            mode = "n";
            key = "<leader>af";
            action = "<cmd>ClaudeCodeFocus<cr>";
            desc = "Focus Claude";
          }
          {
            mode = "n";
            key = "<leader>ar";
            action = "<cmd>ClaudeCode --resume<cr>";
            desc = "Resume Claude";
          }
          {
            mode = "n";
            key = "<leader>aC";
            action = "<cmd>ClaudeCode --continue<cr>";
            desc = "Continue Claude";
          }
          {
            mode = "n";
            key = "<leader>am";
            action = "<cmd>ClaudeCodeSelectModel<cr>";
            desc = "Select Claude model";
          }
          {
            mode = "n";
            key = "<leader>ab";
            action = "<cmd>ClaudeCodeAdd %<cr>";
            desc = "Add current buffer";
          }
          {
            mode = "v";
            key = "<leader>as";
            action = "<cmd>ClaudeCodeSend<cr>";
            desc = "Send to Claude";
          }
          {
            mode = "n";
            key = "<leader>aa";
            action = "<cmd>ClaudeCodeDiffAccept<cr>";
            desc = "Accept diff";
          }
          {
            mode = "n";
            key = "<leader>ad";
            action = "<cmd>ClaudeCodeDiffDeny<cr>";
            desc = "Deny diff";
          }
        ];

        luaConfigRC = {
          matugen = ''
            local function source_matugen()
              local path = os.getenv("HOME") .. "/.config/nvim/nvim-colors.lua"

              local f = io.open(path, "r")
              if f == nil then
                pcall(vim.cmd, "colorscheme base16")
                return
              end
              f:close()

              pcall(dofile, path)

              pcall(function()
                require("lualine").setup({
                  options = { theme = "base16" }
                })
              end)
            end

            source_matugen()

            vim.api.nvim_create_autocmd("Signal", {
              pattern = "SIGUSR1",
              callback = function()
                source_matugen()
              end,
            })
          '';

          claudecode_filetree = ''
            vim.api.nvim_create_autocmd("FileType", {
              pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
              callback = function(args)
                vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", {
                  buffer = args.buf,
                  desc = "Add file",
                })
              end,
            })
          '';
        };
      };
    };
  };
}
