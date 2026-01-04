{ pkgs, ... }:

let
  waybarLaunch = pkgs.writeShellScriptBin "waybar-launch" ''
    set -euo pipefail

    # If waybar is managed by systemd --user, stop it cleanly
    if ${pkgs.systemd}/bin/systemctl --user list-unit-files | ${pkgs.gnugrep}/bin/grep -q '^waybar\.service'; then
      ${pkgs.systemd}/bin/systemctl --user stop waybar.service || true
      ${pkgs.systemd}/bin/systemctl --user reset-failed waybar.service || true
    fi

    # Kill any remaining waybar processes (in case it was started manually)
    ${pkgs.procps}/bin/pkill -u "$USER" -f '(^|/)waybar($| )' || true

    # Wait until all waybar processes are actually gone
    for _ in $(seq 1 20); do
      ${pkgs.procps}/bin/pgrep -u "$USER" -f '(^|/)waybar($| )' >/dev/null || break
      ${pkgs.coreutils}/bin/sleep 0.05
    done

    # Start waybar
    exec ${pkgs.waybar}/bin/waybar
  '';
in
{
  home.packages = [ waybarLaunch ];
}

