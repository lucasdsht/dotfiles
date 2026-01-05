{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Tela-dark"; 
      package = pkgs.tela-icon-theme;
    };
    
    cursorTheme = {
      name = "Graphite-dark";
      package = pkgs.graphite-cursors;
      size = 24;
    };

    
    gtk3.extraCss = ''
      @import "colors.css";
    '';

    gtk4.extraCss = ''
      @import "colors.css";
    '';

  };
}

