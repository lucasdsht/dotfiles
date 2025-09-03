import Quickshell
import QtQuick
import Quickshell.Wayland
import qs.utils

PanelWindow {
  id: dashboard
  
  property bool open: false


  width: 300 
  height: 800
  color: "transparent"
  visible: dashboard.open

  anchors {
    right: true
  }

  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.exclusionMode: ExclusionMode.Normal
  WlrLayershell.namespace: "qs-network-drawer"

  Rectangle {
    anchors.fill: parent
    color: Theme.surface1
    radius: Theme.roundedMd
    border {
      width: Theme.borderMd
      color: Theme.accent
    }


    Text {
      color: Theme.text
      text: "Dashboard"
    }
  }
}
