{config, pkgs, inputs, ...}:

{
  home.packages = [
    inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.matugen = {
    enable = true;

    templates = {
      kitty = {
        input_path = ./templates/kitty-colors.conf;
        output_path = "${config.home.homeDirectory}/.config/kitty/colors.conf";
        post_hook = "${pkgs.procps}/bin/pkill -USR1 kitty || true";

      };
      yazi = {
        input_path = ./templates/yazi-theme.toml;
        output_path = "${config.home.homeDirectory}/.config/yazi/theme.toml";
      };
      waybar = {
        input_path = ./templates/colors.css;
        output_path = "${config.home.homeDirectory}/.config/waybar/colors.css";
        post_hook = "pkill -SIGUSR2 waybar";
      };
    };
  };

  gtk = {
    enable = true;
    gtk4.extraCss = "@import url(\"${config.programs.matugen.theme.files}/.config/gtk-4.0/gtk.css\");";
    gtk3.extraCss = "@import url(\"${config.programs.matugen.theme.files}/.config/gtk-3.0/gtk.css\");";
  };
}
