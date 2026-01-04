{ pkgs, self, ... }:

{
  stylix = {
    enable = true;
    image = self + /assets/wallpapers/wp.png;

    # KEEP: fonts only
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
      sizes.terminal = 15;
    };

    # OPTIONAL: keep cursor if you want
    cursor = {
      package = pkgs.catppuccin-cursors.mochaGreen;
      name = "catppuccin-mocha-green";
      size = 24;
    };

  };
}

