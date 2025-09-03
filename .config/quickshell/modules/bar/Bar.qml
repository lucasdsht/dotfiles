import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components" as C
import "../popups" as P
import qs.utils

PanelWindow {
  id: bar
  width: 56
  color: Theme.base
  visible: true


  anchors.top: true
  anchors.left: true
  anchors.bottom: true

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 8

    // ── TOP (launcher + workspaces) ──
    ColumnLayout {
      Layout.fillWidth: true
      C.Launcher { Layout.alignment: Qt.AlignHCenter; Layout.preferredHeight: 40; Layout.preferredWidth: 40; }
      C.Workspaces { Layout.fillWidth: true }
    }

    // ── Spacer to push middle content into center ──
    Item { Layout.fillHeight: true }

    // ── MIDDLE (current window activity/title) ──
    C.ActiveWindow {
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignHCenter
    }

    // ── Spacer to push bottom content down ──
    Item { Layout.fillHeight: true }

    P.NetworkDrawer { id: netDrawer }
    // ── BOTTOM (battery, wifi, etc.) ──
    ColumnLayout {
      Layout.fillWidth: true
      spacing: 6

      C.Battery    { Layout.fillWidth: true }
      C.Network    { Layout.fillWidth: true; Layout.alignment: Qt.AlignHCenter; drawer: netDrawer }
      C.Bluetooth  { Layout.fillWidth: true; Layout.alignment: Qt.AlignHCenter;}
      C.ThemeToggle      { Layout.fillWidth: true; Layout.alignment: Qt.AlignHCenter; }
      C.Clock      { Layout.fillWidth: true; Layout.alignment: Qt.AlignHCenter; }
      C.PowerMenu  { Layout.preferredHeight: 40; Layout.preferredWidth: 40;}
    }

  }
}

