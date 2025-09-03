import Quickshell
import QtQuick
import Quickshell.Wayland
import qs.utils

PanelWindow {
  id: dashboard
  property bool open: false

  width: 350
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
    anchors.rightMargin: 20
    color: Theme.base
    radius: Theme.roundedLg
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
