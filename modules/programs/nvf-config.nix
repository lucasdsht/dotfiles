{...}:

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
      };
    };
  };
}
