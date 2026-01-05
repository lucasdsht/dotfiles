{ config, pkgs, ... }:

{
  gtk = {
    iconTheme = {
      name = "Tela-dark"; 
      package = pkgs.tela-icon-theme;
    };

  };

  xdg.configFile."gtk-3.0/gtk.css".text = ''
    @import url("colors.css");
  '';

  xdg.configFile."gtk-4.0/gtk.css".text = ''
    @import url("colors.css");
  '';
}

