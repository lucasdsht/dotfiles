import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland as H
import qs.utils
import "../Notifications"

PanelWindow {
  id: dashboard
  property bool open: false

  implicitWidth: 350
  implicitHeight: 800
  color: "transparent"
  visible: dashboard.open

  anchors {
    right: true
  }

  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.exclusionMode: ExclusionMode.Normal
  WlrLayershell.namespace: "qs-dashboard-drawer"

  Rectangle {
    anchors.fill: parent
    anchors.rightMargin: 20
    color: Theme.base
    radius: Theme.roundedLg
    border {
      width: Theme.borderMd
      color: Theme.accent
    }

    Profile {}
    //Feed { Layout.fillHeight: true; Layout.fillWidth: true }
  }


  H.GlobalShortcut {
    name: "dashboard_toggle"
    description: "visible dashboard"
    onPressed: {
      dashboard.open = !dashboard.open
    }
  }
}
