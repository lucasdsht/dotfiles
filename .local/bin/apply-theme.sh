#!/usr/bin/env bash
# Apply Catppuccin theme system-wide
# Usage: apply-theme.sh mocha|latte

set -euo pipefail
FLAVOUR="${1:-mocha}"
# Save current flavour for other apps (nvim, tmux, kitty, etc.)
echo "$FLAVOUR" > "$HOME/.cache/theme"
LOG="$HOME/.cache/apply-theme.log"
mkdir -p "$(dirname "$LOG")"

log() { echo "[$(date +%H:%M:%S)] $*" | tee -a "$LOG"; }

# ───────────────────────────────────────────────
# 1. GTK / Qt (system theme)
# ───────────────────────────────────────────────
apply_gtk_qt() {
  log "Applying GTK/Qt → $FLAVOUR"
  gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-$FLAVOUR"
  if [ "$FLAVOUR" = "mocha" ]; then
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
  else
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
  fi
  gsettings set org.gnome.desktop.interface icon-theme "Papirus"
}

# ───────────────────────────────────────────────
# 2. Kitty terminal
# ───────────────────────────────────────────────
apply_kitty() {
  log "Applying Kitty → $FLAVOUR"
  local conf_dir="$HOME/.config/kitty"
  local target="$conf_dir/current-theme.conf"

  ln -sf "$conf_dir/catppuccin-${FLAVOUR}.conf" "$target"

  # --- Detect Kitty socket ---
  local SOCKET="unix:/tmp/kitty-$USER"

  # If the exact socket is missing, look for the most recent suffixed one
  if [ ! -S "${SOCKET#unix:}" ]; then
    DETECTED=$(ls -1t /tmp/kitty-$USER-* 2>/dev/null | head -n1 || true)
    if [ -n "$DETECTED" ]; then
      # strip any trailing '=' just in case
      DETECTED_CLEAN="${DETECTED%=}"
      SOCKET="unix:$DETECTED_CLEAN"
    fi
  fi

  export KITTY_LISTEN_ON="$SOCKET"
  log "Kitty → using socket $KITTY_LISTEN_ON"

  # --- Apply theme if socket works ---
  if kitty @ --to "$KITTY_LISTEN_ON" ls >/dev/null 2>&1; then
    kitty @ --to "$KITTY_LISTEN_ON" set-colors -a "$target"
    log "Kitty reloaded via socket ($KITTY_LISTEN_ON)"
  else
    log "Kitty socket not reachable ($KITTY_LISTEN_ON) — restart Kitty to apply $FLAVOUR"
  fi
}

# ───────────────────────────────────────────────
# 3. Tmux
# ───────────────────────────────────────────────
apply_tmux() {
  log "Applying Tmux → $FLAVOUR"
  local tmux_theme="$HOME/.config/tmux/current-theme.tmuxtheme"

  # point symlink to your custom themes
  ln -sf "$HOME/.config/tmux/themes/catppuccin_${FLAVOUR}.tmuxtheme" "$tmux_theme"

  if tmux has-session 2>/dev/null; then
    tmux source-file "$HOME/.config/tmux/tmux.conf"
    tmux refresh-client -S
    log "Tmux reloaded"
  fi
}

# ───────────────────────────────────────────────
# 4. Neovim
# ───────────────────────────────────────────────
apply_nvim() {
  log "Applying Neovim → $FLAVOUR"

  if command -v nvr >/dev/null 2>&1 && pgrep -x nvim >/dev/null 2>&1; then
    nvr --remote-expr "lua require('catppuccin').load('$FLAVOUR')" \
      && log "Neovim theme switched to $FLAVOUR"
  else
    log "Neovim not running or nvr not installed (will use $FLAVOUR on next launch)"
  fi
}

# ───────────────────────────────────────────────
# 5. Zen Browser
# ───────────────────────────────────────────────
apply_zen() {
  log "Applying Zen → $FLAVOUR"
  local profile="$HOME/.zen/r2ll13rw.Default (alpha)"
  local prefs="$profile/prefs.js"

  if [ "$FLAVOUR" = "mocha" ]; then
    sed -i 's/user_pref("ui.systemUsesDarkTheme".*/user_pref("ui.systemUsesDarkTheme", 1);/' "$prefs" \
      || echo 'user_pref("ui.systemUsesDarkTheme", 1);' >> "$prefs"
  else
    sed -i 's/user_pref("ui.systemUsesDarkTheme".*/user_pref("ui.systemUsesDarkTheme", 0);/' "$prefs" \
      || echo 'user_pref("ui.systemUsesDarkTheme", 0);' >> "$prefs"
  fi

  # restart Zen to apply
  if pgrep -x zen-browser >/dev/null 2>&1; then
    pkill -x zen-browser
    (zen-browser >/dev/null 2>&1 & disown)
    log "Zen restarted with $FLAVOUR"
  fi
}

# ───────────────────────────────────────────────
# Run all
# ───────────────────────────────────────────────
apply_gtk_qt
apply_kitty
apply_tmux
apply_nvim
apply_zen

log "Theme applied → $FLAVOUR"

