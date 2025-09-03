import QtQuick
import Quickshell.Hyprland as H
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.utils

Button {
  id: themeToggle
  width: 20; height: 20

  background: Rectangle {
    radius: 10
    color: "transparent"
  }

  onClicked: Theme.isDarkTheme = !Theme.isDarkTheme

  Text {
    anchors.centerIn: parent
    font.bold: true
    font.pixelSize: 24
    color: Theme.text
    text: Theme.isDarkTheme ? "" : ""
  }
}

