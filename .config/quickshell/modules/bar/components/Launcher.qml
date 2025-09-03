import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.utils

Button {
  id: launcher
  width: 40; height: 40

  background: Rectangle {
    radius: 10
    color: Theme.red //"#f38ba8"
  }

  Process {
    id: wofiTrigger
    command: ["wofi", "--show", "drun"] // launcher WIP
  }

  onClicked: wofiTrigger.running = true
  Text {
    anchors.centerIn: parent
    font.bold: true
    font.pixelSize: 24
    text: ""
  }
}

