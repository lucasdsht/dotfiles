{ pkgs, ... }:

{
  stylix = {
    enable = true;

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

    # Disable ALL theming targets
    targets = {
      gtk.enable = false;
      waybar.enable = false;
      kitty.enable = false;
      firefox.enable = false;
      hyprland.enable = false;
      neovim.enable = false;
      alacritty.enable = false;
      fish.enable = false;
      tmux.enable = false;
    };
  };
}

