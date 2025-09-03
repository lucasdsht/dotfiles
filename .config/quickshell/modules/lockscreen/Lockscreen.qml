import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland as H

PanelWindow {
  id: lockscreen
  anchors {
    top: true
    bottom: true
    right: true
    left: true
  }
  color: "#1e1e2e"
  visible: false

  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.exclusionMode: ExclusionMode.Normal   // ← block input passthrough
  WlrLayershell.namespace: "qs-lockscreen"

  property bool authenticating: false
  property string message: "Enter password"

  // block mouse clicks from leaking
  MouseArea { anchors.fill: parent; onClicked: input.forceActiveFocus() }

  Rectangle {
    anchors.centerIn: parent
    width: 320; height: 200
    radius: 12
    color: "#181825"
    border.color: "#585b70"; border.width: 1

    Column {
      anchors.centerIn: parent
      spacing: 16

      Label {
        text: lockscreen.message
        color: "white"
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
      }

      TextField {
        id: input
        width: 240
        echoMode: TextInput.Password
        placeholderText: "Password"
        Keys.onReturnPressed: tryUnlock()
      }

      Button {
        text: lockscreen.authenticating ? "Checking…" : "Unlock"
        enabled: !lockscreen.authenticating
        onClicked: tryUnlock()
      }
    }
  }

  onVisibleChanged: if (visible) {
    input.text = ""
    input.forceActiveFocus()
    lockscreen.message = "Enter password"
  }

  function tryUnlock() {
    if (lockscreen.authenticating) return
    if (!input.text || input.text.length === 0) return

    lockscreen.authenticating = true
    lockscreen.message = "Checking…"

    check.command = [
      "bash","-lc",
      `echo '${input.text.replace(/'/g,"'\\''")}' | systemd-ask-password --no-tty --quiet --timeout=2 "Unlock Session"`
    ]
    check.start()
  }

  Process {
    id: check
    stdout: StdioCollector {
      onStreamFinished: {
        lockscreen.authenticating = false
        if (check.exitCode === 0) {
          unlock.command = ["bash","-lc","loginctl unlock-session $XDG_SESSION_ID"]
          unlock.start()
          lockscreen.visible = false
        } else {
          lockscreen.message = "Wrong password"
          input.text = ""
          input.forceActiveFocus()
        }
      }
    }
    stderr: StdioCollector {
      onStreamFinished: {
        if (this.text && this.text.trim().length > 0) {
          lockscreen.authenticating = false
          lockscreen.message = "Error: " + this.text.trim()
        }
      }
    }
  }

  Process { id: unlock }

  // hotkey from Hyprland
  H.GlobalShortcut {
    name: "lockscreen_toggle"
    description: "Show lockscreen"
    onPressed: lockscreen.visible = true
  }

  // auto-lock after 5 min idle
  Timer {
    id: idleTimer
    interval: 5 * 60 * 1000; running: true; repeat: true
    onTriggered: lockscreen.visible = true
  }
}

