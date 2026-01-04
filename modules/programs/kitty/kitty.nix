{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      size = 15;
      name = "JetBrainsMono Nerd Font Mono";
    };
    # boldFont = "FiraCode Nerd Font Mono Bold";
    # italicFont = "Hasklug Nerd Font Mono Italic";

    # adjustLineHeight = 3;
    # windowPaddingWidth = 5.0;
    # backgroundOpacity = 1;
    
    extraConfig = ''
      include extra.conf
      include colors.conf
    '';

  };
  home.file.".config/kitty/extra.conf" = {
    source = ./extra.conf;
  };

  home.file.".config/kitty/colors/matugen.conf" = {
    source = ./matugen.conf;
  };
}
