import QtQuick
import QtQuick.Controls

Column {
  id: clock
  padding: 10
  spacing: 2
  property var now: new Date()

  Label {
    id: hourLabel
    text: Qt.formatDateTime(clock.now, "HH")
    font.pixelSize: 20
    font.bold: true
    color: "white"
    horizontalAlignment: Text.AlignHCenter
  }

  Label {
    id: minuteLabel
    text: Qt.formatDateTime(clock.now, "mm")
    font.pixelSize: 20
    color: "white"
    horizontalAlignment: Text.AlignHCenter
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

