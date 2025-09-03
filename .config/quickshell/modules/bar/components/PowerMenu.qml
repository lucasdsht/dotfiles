import Quickshell
import QtQuick
import QtQuick.Controls
import "../../popups"
import qs.utils

Button {
  id: powerButton
  width: 40
  height: 40

  background: Rectangle {
    radius: 10
    color: Theme.accent
  }

  onClicked: Powermenu.visible = !Powermenu.visible

  Text {
    anchors.centerIn: parent
    font.bold: true
    font.pixelSize: 34
    text: "⏻"
  }

}
