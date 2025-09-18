import QtQuick
import Quickshell.Hyprland as H
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.utils

Button {
  id: themeToggle
  width: 40; height: 40
  background: Rectangle { radius: 10; color: "transparent" }

  function applyThemeNow() {
    const flavour = Theme.isDarkTheme ? "mocha" : "latte"
    systemTheme.running = false              // reset
    systemTheme.command = ["bash", "-lc", "$HOME/.local/bin/apply-theme.sh " + flavour]
    systemTheme.running = true               // (re)start
  }

  onClicked: {
    Theme.toggleTheme()
    applyThemeNow()
  }

  Text {
    anchors.centerIn: parent
    font.bold: true
    font.pixelSize: 20
    color: Theme.text
    text: Theme.isDarkTheme ? "" : ""
  }

  Process {
    id: systemTheme
    stdout: StdioCollector { onStreamFinished: if (this.text) console.log("apply-theme:", this.text.trim()) }
    stderr: StdioCollector { onStreamFinished: if (this.text) console.warn("apply-theme ERR:", this.text.trim()) }
  }

  // Optionnel: synchroniser au démarrage
  Component.onCompleted: applyThemeNow()


  H.GlobalShortcut {
    name: "theme_toggle"
    description: "swap theme"
    onPressed: {
      Theme.toggleTheme()
      applyThemeNow()
    }
  }
}

