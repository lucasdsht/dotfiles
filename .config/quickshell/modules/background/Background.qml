import QtQuick
import Quickshell
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import qs.utils

PanelWindow {
  id: win

  // === customization ===
  property bool useExternalWallpaper: false
  property real cornerRadius: 20
  property real borderWidth: Theme.borderXxl
  property color borderColor: Theme.base

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

  // 1. Background frame
  Rectangle {
    anchors.fill: parent
    color: win.borderColor
  }

  // 2. Wallpaper with real rounded clipping
  Item {
    anchors.fill: parent
    anchors.margins: win.borderWidth

    Image {
      id: wallpaperImg
      anchors.fill: parent
      source: Theme.wallpaper
      fillMode: Image.PreserveAspectCrop
      smooth: true
      cache: true
      visible: false
    }

    Rectangle {
      id: mask
      anchors.fill: parent
      radius: win.cornerRadius
      visible: false
    }

    OpacityMask {
      anchors.fill: parent
      source: wallpaperImg
      maskSource: mask
    }
  }
}

