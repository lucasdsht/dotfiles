{pkgs, ...}:

pkgs.writeShellScriptsBin "waybarLaunch" ''
  set -euo pipefail

  ${pkgs.procps}/bin/kill -x waybar || true

  ${pkgs.coreutils}/bin/sleep 0.2

  exec ${pkgs.waybar}/bin/waybar

''
