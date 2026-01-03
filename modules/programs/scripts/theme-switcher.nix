{ pkgs, ... }:

let
  themeSwitcher = pkgs.writeShellScriptBin "theme-switcher" ''
    set -euo pipefail

    THEMES_DIR="/nix/var/nix/profiles/system/specialisation"

    if [ ! -d "$THEMES_DIR" ]; then
      echo "No specialisations found in $THEMES_DIR" >&2
      exit 1
    fi

    theme="$(
      ls -1 "$THEMES_DIR" \
        | sort \
        | ${pkgs.wofi}/bin/wofi --dmenu --prompt "Theme"
    )"

    [ -z "''${theme:-}" ] && exit 0

    # Switch system specialisation
    sudo "$THEMES_DIR/$theme/bin/switch-to-configuration" switch
    ${pkgs.procps}/bin/pkill -USR1 kitty >/dev/null 2>&1 || true

    # Reload Hyprland (pick up regenerated config/colors)
    if command -v hyprctl >/dev/null 2>&1; then
      hyprctl reload >/dev/null 2>&1 || true
    fi

    # Re-apply wallpaper via swww (stable symlink you created)
    if command -v swww >/dev/null 2>&1 && [ -e /etc/wallpaper ]; then
      swww img /etc/wallpaper \
        --transition-type any \
        --transition-duration 0.20 \
        >/dev/null 2>&1 || true
    fi
  '';
in
{
  home.packages = [
    themeSwitcher
  ];
}

