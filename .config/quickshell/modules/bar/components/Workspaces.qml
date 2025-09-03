import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland as H
import qs.utils

ColumnLayout {
  id: root
  spacing: 6
  property int itemHeight: 32

  // Bind directly to the Hyprland workspaces model
  Repeater {
    id: rep
    model: H.Hyprland.workspaces   // <- key change

    delegate: Rectangle {
      // modelData is the workspace object
      // You can also use role names if exposed; this is the simplest.
      readonly property var ws: model.modelData
      Layout.fillWidth: true
      Layout.preferredHeight: root.itemHeight
      radius: 8
      color: (ws && H.Hyprland.focusedWorkspace && ws.id === H.Hyprland.focusedWorkspace.id)
             ? Theme.surface1 : "transparent"

      MouseArea {
        anchors.fill: parent
        onClicked: if (ws) H.Hyprland.dispatch("workspace " + ws.id)
        onWheel: {
          if (wheel.angleDelta.y > 0) H.Hyprland.dispatch("workspace -1")
          else if (wheel.angleDelta.y < 0) H.Hyprland.dispatch("workspace +1")
        }
      }

      Row {
        anchors.centerIn: parent
        spacing: 6
        Label { text: ""; color: Theme.text; font.pixelSize: 13 }
      }
    }
  }
}

