import QtQuick
import QtQuick.Controls
import Quickshell.Io
import qs.utils

Control {
  id: root
  property var drawer: netDrawer   // popup drawer instance (wired in shell)

  property string connType: ""   // "wifi" | "ethernet" | ""
  property string ssid: ""
  property bool online: false

  contentItem: Row {
    spacing: 6
    Label {
      text: connType === "ethernet" ? "󰈀" : ""   // ethernet/wifi Nerd Font
      color: Theme.text
      font.pixelSize: 14
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: if (root.drawer) root.drawer.open = true
  }

  // ---- poll active connection ----
  Process {
    id: pActive
    command: ["nmcli", "-t", "-f", "TYPE,STATE,NAME", "connection", "show", "--active", "|", "sed", "-n", "'1p'"]
    stdout: StdioCollector {
      onStreamFinished: {
        const parts = (this.text || "").trim().split(":")
        root.connType = (parts[0] || "").toLowerCase()
        root.online   = (parts[1] || "").includes("activ")
        root.ssid     = root.connType === "wifi" ? parts.slice(2).join(":") : ""
      }
    }
  }

  Timer { interval: 5000; running: true; repeat: true; onTriggered: pActive.running = true }
  Component.onCompleted: pActive.running = true
}

