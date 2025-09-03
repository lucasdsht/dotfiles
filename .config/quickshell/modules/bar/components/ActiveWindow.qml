import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland as H
import qs.utils

Item {
  id: root

  property var bar: null
  property int maxHeight: {
    return bar ? bar.height : (icon.height + 120)
  }

  // Theme knobs
  property int   iconSize: 20
  property int   spacing: 6

  // Active toplevel title/class from Hyprland
  readonly property var active: H.Hyprland.activeToplevel
  readonly property string titleText: active && active.title ? active.title : "Desktop"
  readonly property string className: active && active.lastIpcObject ? active.lastIpcObject.class : ""

  // Two text layers we cross-fade between when the title changes
  property Item current: text1

  // Sizing similar to your ref:
  implicitWidth: Math.max(icon.implicitWidth, current.implicitHeight)
  implicitHeight: icon.implicitHeight + current.implicitWidth + spacing

  // ── Icon (use whatever glyph or icon theme you prefer)
  Label {
    id: icon
    anchors.horizontalCenter: parent.horizontalCenter
    text: ""              // generic window glyph (Nerd Font); replace if you have a mapper
    font.pixelSize: iconSize
    color: Theme.text
  }

  // TextMetrics to compute elided title based on available height below icon
  TextMetrics {
    id: metrics
    text: root.titleText
    font.pointSize: 12
    elide: Qt.ElideRight
    elideWidth: Math.max(0, root.maxHeight - icon.height - spacing)

    onTextChanged: swapText()
    onElideWidthChanged: { root.current.text = elidedText }
    Component.onCompleted: { root.current.text = elidedText }
  }

  // Cross-fade swap
  function swapText() {
    const next = (root.current === text1) ? text2 : text1
    next.text = metrics.elidedText
    root.current = next
  }

  // Shared title component (rotated)
  component RotText: Label {
    id: t
    anchors.top: icon.bottom
    anchors.topMargin: spacing
    anchors.horizontalCenter: icon.horizontalCenter
    color: Theme.text
    font.pointSize: metrics.font.pointSize
    opacity: (root.current === this) ? 1 : 0

    // rotate 90° to read from bottom to top
    transform: Rotation {
      angle: 90
      origin.x: t.implicitHeight / 2
      origin.y: t.implicitHeight / 2
    }

    // swap logical width/height after rotation for layout math
    width: implicitHeight
    height: implicitWidth

    Behavior on opacity { NumberAnimation { duration: 160 } }
  }

  RotText { id: text1; text: "" }
  RotText { id: text2; text: "" }

  // Smooth overall height adjustments (optional)
  Behavior on implicitHeight { NumberAnimation { duration: 160 } }
}

