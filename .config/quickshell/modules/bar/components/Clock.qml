import QtQuick
import QtQuick.Controls
import qs.utils

Column {
  id: clock
  spacing: 2
  property var now: new Date()

  anchors.horizontalCenter: parent ? undefined : undefined
  width: parent ? parent.width : implicitWidth

  Label {
    id: hourLabel
    text: Qt.formatDateTime(clock.now, "HH")
    font.pixelSize: 20
    font.bold: true
    color: Theme.text
    horizontalAlignment: Text.AlignHCenter
    anchors.horizontalCenter: parent.horizontalCenter   // key
  }

  Label {
    id: minuteLabel
    text: Qt.formatDateTime(clock.now, "mm")
    font.pixelSize: 20
    color: Theme.text
    horizontalAlignment: Text.AlignHCenter
    anchors.horizontalCenter: parent.horizontalCenter   // key
  }

  Timer {
    interval: 1000; repeat: true; running: true
    onTriggered: {
      clock.now = new Date()
      hourLabel.text   = Qt.formatDateTime(clock.now, "HH")
      minuteLabel.text = Qt.formatDateTime(clock.now, "mm")
    }
  }
}

