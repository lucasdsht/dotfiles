{ config, lib, ... }:

{
  # Copy your matugen config + templates from the repo into ~/.config/matugen
  xdg.configFile."matugen/config.toml".source = ./files/config.toml;
  xdg.configFile."matugen/templates".source = ./files/templates;

  # IMPORTANT: don’t manage files that matugen must write to (colors.conf, gtk css outputs, etc.)
  # Ensure output dirs exist:
  home.activation.matugenDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.xdg.configHome}/kitty/colors"
    mkdir -p "${config.xdg.configHome}/gtk-3.0"
    mkdir -p "${config.xdg.configHome}/gtk-4.0"
    mkdir -p "${config.xdg.configHome}/waybar"
    mkdir -p "${config.xdg.configHome}/matugen/generated"
  '';
}

