import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io

Button {
  id: launcher
  width: 40; height: 40

  background: Rectangle {
    radius: 10
    color: "#f38ba8"
  }

  Process {
    id: wofiTrigger
    command: ["wofi", "--show", "drun"]
  }

  onClicked: wofiTrigger.running = true
  Text {
    anchors.centerIn: parent
    text: ""
  }
}

