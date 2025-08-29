import Quickshell
import QtQuick
import QtQuick.Controls
import "../../powermenu"

Button {
  id: powerButton
  width: 40
  height: 40

  background: Rectangle {
    radius: 10
    color: "#a6e3a1"
  }

  onClicked: powermenu.visible = !powermenu.visible

  Text {
    anchors.centerIn: parent
    font.bold: true
    font.pixelSize: 34
    text: "⏻"
  }

  PanelWindow {
    id: powermenu
    implicitWidth: 500
    implicitHeight: 300
    visible: false

    Text {
      text: "powermenu"
    }  
  }
}
