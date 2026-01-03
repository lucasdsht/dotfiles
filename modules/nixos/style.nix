{pkgs, self, ...}:

{
  stylix = {
    enable = true;

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        terminal = 15;
      }; 
    };
    
    cursor = {
      package = pkgs.catppuccin-cursors.mochaGreen;
      name = "catppuccin-mocha-green";
      size = 24;
    };
    
    polarity = "dark";

    image = self + /assets/wallpapers/wp.png;
  };
}
