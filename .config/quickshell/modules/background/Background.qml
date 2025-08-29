import QtQuick
import Quickshell
import Quickshell.Wayland 
import QtQuick.Shapes 
import Qt5Compat.GraphicalEffects 

PanelWindow {
  id: win
  // === customize these ===
  property url wallpaperSource: ""
  property bool useExternalWallpaper: false
  property real cornerRadius: 0
  property real borderWidth: 10
  property color borderColor: "#1e1e2e"
  //property color borderColor: "red"
  readonly property real inset: borderWidth / 2

  visible: !useExternalWallpaper && wallpaperSource !== ""
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

  // base image (hidden, used as source for mask)
  Image {
    id: img
    anchors.fill: parent
    source: win.wallpaperSource
    fillMode: Image.PreserveAspectCrop
    visible: false
    cache: true
    smooth: true
  }

  // mask shape for rounded corners
  Rectangle {
    id: maskRect
    anchors.fill: parent
    anchors.margins: win.inset
    //radius: Math.max(0, win.cornerRadius - win.inset)
    visible: false
  }

  // masked wallpaper (applies rounded corners)
  OpacityMask {
    anchors.fill: parent
    source: img
    maskSource: maskRect
  }

  // stroke border around the screen
  Shape {
    anchors.fill: parent
    ShapePath {
      strokeColor: win.borderColor
      strokeWidth: win.borderWidth
      fillColor: "transparent"

      PathRectangle {
        x: win.inset
        y: win.inset
        width: win.width  - 2 * win.inset
        height: win.height - 2 * win.inset
        //radius: Math.max(0, win.cornerRadius - win.inset)
      }
    }
  }
}

