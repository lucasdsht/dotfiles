import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.UPower

Control {
  id: root
  readonly property int percent: {
    const d = UPower.displayDevice
    if (!d || isNaN(d.percentage)) return -1
    return Math.round(d.percentage * 100)
  }

  contentItem: Label {
    text: root.percent >= 0 ? `${root.percent}%` : "?%"
    color: "white"
    font.pixelSize: 13
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }
}

