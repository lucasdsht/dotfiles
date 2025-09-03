import QtQuick
import Quickshell
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import qs.utils

PanelWindow {
  id: win

  // === customize ===
  property bool  useExternalWallpaper: false
  property real  cornerRadius: 20
  property real  borderWidth: Theme.borderXxl
  property color borderColor: Theme.base

  property int reservedLeft: 56

  visible: !useExternalWallpaper && Theme.wallpaper !== ""
  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }
  color: "transparent"

  WlrLayershell.layer: WlrLayer.Background
  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  WlrLayershell.namespace: "quickshell-wallpaper"

  // 1) Fullscreen frame (will be under the bar on the left—fine)
  Rectangle {
    anchors.fill: parent
    color: win.borderColor
  }

  // 2) Inset, rounded wallpaper area (starts after the bar)
  Item {
    id: content
    anchors.fill: parent
    anchors.margins: borderWidth
    anchors.leftMargin: reservedLeft

    // image to be masked
    Image {
      id: wp
      anchors.fill: parent
      source: Theme.wallpaper
      fillMode: Image.PreserveAspectCrop
      smooth: true
      cache: true
      visible: false
    }

    // rounded mask
    Rectangle {
      id: mask
      anchors.fill: parent
      radius: cornerRadius
      visible: false
    }

    // apply rounded clipping
    OpacityMask {
      anchors.fill: parent
      source: wp
      maskSource: mask
    }
  }
}

