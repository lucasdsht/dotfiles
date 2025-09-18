import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import qs.utils

PanelWindow {
  id: drawer
  property bool open: false
  property int widthPx: 360
  visible: open
  width: widthPx
  height: 500
  color: "transparent"
  margins.left: 5

  anchors.left: true
  anchors.bottom: true

  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.exclusionMode: ExclusionMode.Normal
  WlrLayershell.namespace: "qs-network-drawer"

  // Slide-in
  Item {
    anchors.fill: parent
    x: open ? 0 : widthPx
    Behavior on x { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }

    Rectangle {
      anchors.fill: parent
      color: Theme.surface0
      radius: 12
      border.color: Theme.accent; border.width: Theme.borderMd

      ColumnLayout {
        anchors.fill: parent; anchors.margins: 12; spacing: 8

        RowLayout {
          Layout.fillWidth: true
          Label { text: "Networks"; color: Theme.text; font.bold: true }
          Item { Layout.fillWidth: true }
          ToolButton {
            text: ""; onClicked: drawer.open = false
            contentItem: Label { text: parent.text; color: Theme.text }
          }
        }

        Button { text: "Scan"; onClicked: scanWifi() }
        Label { id: status; text: ""; color: Theme.text }

        ListView {
          id: list
          Layout.fillWidth: true; Layout.fillHeight: true
          spacing: 6; clip: true
          model: networks

          delegate: Rectangle {
            required property var modelData
            width: list.width; height: 48
            radius: 8; border.width: 1; border.color: "#313244"; color: "transparent"

            RowLayout {
              anchors.fill: parent; anchors.margins: 8; spacing: 10
              Label { text: modelData.locked ? "" : ""; color: "#cdd6f4" }
              Label {
                text: modelData.ssid || "(hidden)"; color: "#cdd6f4"
                Layout.fillWidth: true; elide: Text.ElideRight
              }
              Button { text: "Connect"; onClicked: connectToSsid(modelData) }
            }
          }
        }

        RowLayout {
          id: pwdRow
          Layout.fillWidth: true; visible: askPassword; spacing: 8
          Label { text: "Password"; color: "#cdd6f4" }
          TextField {
            id: pwdInput; Layout.fillWidth: true
            echoMode: TextInput.Password; placeholderText: "Enter password"
            color: "#cdd6f4"
          }
          Button { text: "OK"; onClicked: doConnectWithPassword() }
        }
      }
    }
  }

  // ---- model & logic ----
  ListModel { id: networks }
  property string pendingSsid: ""
  property bool askPassword: false

  function scanWifi() {
    status.text = "Scanning…"; networks.clear(); pScan.running = true
  }

  function connectToSsid(n) {
    pendingSsid = n.ssid
    if (n.locked) { askPassword = true; pwdInput.text = ""; pwdInput.forceActiveFocus() }
    else {
      askPassword = false
      status.text = `Connecting to ${pendingSsid}…`
      pConnect.command = ["bash","-lc",`nmcli dev wifi connect "${pendingSsid}"`]
      pConnect.running = true
    }
  }

  function doConnectWithPassword() {
    askPassword = false
    status.text = `Connecting to ${pendingSsid}…`
    pConnect.command = ["bash","-lc",
      `nmcli dev wifi connect "${pendingSsid}" password "${pwdInput.text}"`]
    pConnect.running = true
  }

  // ---- processes ----
  Process {
    id: pScan
    command: ["nmcli", "-t", "-f", "SSID,SIGNAL,SECURITY", "dev", "wifi", "list"]
    stdout: StdioCollector {
      onStreamFinished: {
        networks.clear()
        for (let line of (this.text || "").trim().split(/\\n/)) {
          if (!line) continue
          const [ssid, signal, sec] = line.split(":")
          networks.append({ ssid, signal: parseInt(signal||0), locked: (sec && sec !== "--") })
        }
        status.text = `${networks.count} network(s) found`
      }
    }
  }

  Process {
    id: pConnect
    stdout: StdioCollector { onStreamFinished: status.text = this.text.trim() }
    stderr: StdioCollector { onStreamFinished: if (this.text) status.text = "Error: " + this.text }
  }

  onOpenChanged: if (open) scanWifi()
}

